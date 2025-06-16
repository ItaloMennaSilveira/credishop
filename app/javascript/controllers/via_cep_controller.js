import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["zip", "street", "city", "state"]

  connect() {
    if (this.hasZipTarget) {
      this.zipTarget.addEventListener("blur", () => this.fetchAddress())
      this.zipTarget.addEventListener("keydown", (event) => {
        if (event.key === "Enter") {
          event.preventDefault()
          this.fetchAddress()
        }
      })
    }
  }

  fetchAddress() {
    const zip = this.zipTarget.value.replace(/\D/g, "")
    if (zip.length !== 8) return

    fetch(`https://viacep.com.br/ws/${zip}/json/`)
      .then(response => response.json())
      .then(data => {
        if (data.erro) {
          console.error("CEP não encontrado")
          return
        }

        if (this.hasStreetTarget) this.streetTarget.value = data.logradouro || ""
        if (this.hasCityTarget) this.cityTarget.value = data.localidade || ""
        if (this.hasStateTarget) this.stateTarget.value = data.uf || ""
      })
      .catch(() => {
        console.error("Erro ao buscar CEP")
      })
  }
}
