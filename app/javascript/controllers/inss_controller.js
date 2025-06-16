import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

export default class extends Controller {
  static targets = ["salary", "salaryMasked"]
  static values = { token: String }

  connect() {
    if (!this.hasTokenValue) {
      this.tokenValue = crypto.randomUUID()
    }

    this.subscription = consumer.subscriptions.create(
      { channel: "InssRateChannel", token: this.tokenValue },
      {
        received: (data) => this.updateRateFields(data)
      }
    )
  }

  disconnect() {
    if (this.subscription) {
      this.subscription.unsubscribe()
    }
  }

  calculate(event) {
    if (event.type === "keydown" && event.key !== "Enter") return
    if (event.type === "keydown") event.preventDefault()

    const maskedSalary = this.salaryMaskedTarget?.value
    const unmaskedSalary = this.unmaskSalary(maskedSalary)

    if (!unmaskedSalary) return

    if (this.hasSalaryTarget) {
      this.salaryTarget.value = unmaskedSalary
    }

    fetch("/proponents/calculate_inss", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ salary: unmaskedSalary, token: this.tokenValue })
    }).catch(error => console.error("INSS calc request failed", error))
  }

  updateRateFields(data) {
    const rateField = document.querySelector("#proponent_inss_rate")
    const rateTypeField = document.querySelector("#proponent_inss_rate_type")
    const rateTypeDisplay = document.querySelector("#proponent_inss_rate_type_display")

    if (rateField) rateField.value = data.inss_rate
    if (rateTypeField) rateTypeField.value = data.inss_rate_type
    if (rateTypeDisplay) rateTypeDisplay.value = data.inss_rate_type
  }

  unmaskSalary(value) {
    if (!value) return ""
    return value.replace(/\./g, "").replace(",", ".")
  }
}
