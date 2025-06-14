import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["salary"]
  static values = { proponentId: Number }

  connect() {
    this.channel = `proponent_${this.proponentIdValue}`
    this.subscribeToChannel()
  }

  calculate(event) {
    if (event.type === "keydown") {
      if (event.key !== "Enter") return
      event.preventDefault()
    }

    const salary = this.salaryTarget.value
    if (!salary) return

    fetch("/proponents/calculate_inss", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        salary: salary,
        proponent_id: this.proponentIdValue
      })
    })
  }

  subscribeToChannel() {
    const channelName = this.channel
    const element = document.querySelector(`[data-controller~="inss"]`)

    if (!element) return

    const observer = new MutationObserver(() => {
      const rateField = document.querySelector("#proponent_inss_rate")
      const rateTypeField = document.querySelector("#proponent_inss_rate_type")

      const inssRateElement = document.querySelector("[data-inss-rate]")
      const inssRateTypeElement = document.querySelector("[data-inss-rate-type]")

      if (inssRateElement && inssRateTypeElement) {
        if (rateField) rateField.value = inssRateElement.dataset.inssRate
        if (rateTypeField) rateTypeField.value = inssRateTypeElement.dataset.inssRateType
      }
    })

    observer.observe(document.body, { childList: true, subtree: true })
  }
}
