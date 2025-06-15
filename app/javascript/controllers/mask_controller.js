import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["salary", "document", "number", "zip", "contactType", "contactValue"]

  connect() {
    if (typeof IMask === "undefined") {
      console.error("IMask not loaded")
      return
    }

    if (this.hasSalaryTarget) {
      this.setupMask("salary", {
        mask: Number,
        scale: 2,
        signed: false,
        thousandsSeparator: ".",
        radix: ",",
        padFractionalZeros: true,
        normalizeZeros: true,
      }, "proponent[salary]")
    }

    if (this.hasDocumentTarget) {
      this.setupMask("document", {
        mask: "000.000.000-00"
      }, "proponent[document]")
    }

    if (this.hasNumberTarget) {
      this.setupMask("number", {
        mask: Number,
        signed: false
      }, "proponent[number]")
    }

    if (this.hasZipTarget) {
      this.setupMask("zip", {
        mask: "00000-000"
      }, "proponent[zip_code]")
    }

    if (this.hasContactTypeTarget && this.hasContactValueTarget) {
      this.contactTypeTarget.addEventListener("change", () => this.setupContactMask())
      this.setupContactMask()
    }
  }

  setupMask(targetName, maskOptions, defaultHiddenFieldName = null) {
    const target = this[`${targetName}Target`]
    if (!target) return

    const hiddenName = target.dataset.hiddenName || defaultHiddenFieldName
    const hiddenInput = document.querySelector(`input[name="${hiddenName}"]`)
    if (!hiddenInput) {
      console.warn(`Hidden input with name '${hiddenName}' not found.`)
      return
    }

    const mask = IMask(target, maskOptions)

    mask.on("accept", () => {
      hiddenInput.value = mask.unmaskedValue
    })

    if (hiddenInput.value) {
      mask.value = hiddenInput.value
    }
  }

  setupContactMask() {
    const type = this.contactTypeTarget.value
    const input = this.contactValueTarget
    const hiddenInput = input.closest('.contact-fields')?.querySelector('input[name*="[value]"]')

    if (!input || !hiddenInput) return

    if (input._mask) {
      input._mask.destroy()
    }

    switch (type) {
      case "phone":
      case "whatsapp":
        input.placeholder = "(00) 00000-0000"
        input._mask = IMask(input, {
          mask: "(00) 00000-0000"
        })
        input._mask.on("accept", () => {
          hiddenInput.value = input._mask.unmaskedValue
        })

        if (hiddenInput.value) {
          input._mask.value = hiddenInput.value
        }

        break

      case "email":
        input.placeholder = "exemplo@email.com"
        input.value = hiddenInput.value
        input.addEventListener("input", () => {
          hiddenInput.value = input.value
        })
        break

      default:
        input.placeholder = "Digite o valor"
    }
  }
}
