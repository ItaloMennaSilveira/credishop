import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["salary"]

  calculate(event) {
    if (event.type === "keydown") {
      if (event.key !== "Enter") return
      event.preventDefault()
    }

    const salary = document.querySelector('input[name="proponent[salary]"]')?.value
    if (!salary) return

    fetch("/proponents/calculate_inss", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ salary: salary })
    }).then(response => response.json())
      .then(data => this.updateRateFields(data))
      .catch(error => console.error("INSS calculation error:", error))
  }

  updateRateFields(data) {
    const rateField = document.querySelector("#proponent_inss_rate");
    const rateTypeField = document.querySelector("#proponent_inss_rate_type");
    const rateTypeDisplay = document.querySelector("#proponent_inss_rate_type_display");

    if (rateField) rateField.value = data.inss_rate;
    if (rateTypeField) rateTypeField.value = data.inss_rate_type;
    if (rateTypeDisplay) rateTypeDisplay.value = data.inss_rate_type;
  }
}
