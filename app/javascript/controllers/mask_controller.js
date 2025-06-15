import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["salary", "document"]

  connect() {
    if (typeof IMask === "undefined") {
      console.error("IMask not loaded")
      return
    }

    if (this.hasSalaryTarget) {
      IMask(this.salaryTarget, {
        mask: Number,
        scale: 2,
        signed: false,
        thousandsSeparator: ".",
        radix: ",",
        padFractionalZeros: true,
        normalizeZeros: true,
      })
    }

    if (this.hasDocumentTarget) {
      IMask(this.documentTarget, {
        mask: "000.000.000-00",
      })
    }
  }
}
