import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["previewInput"]

  connect() {
    const baseUrl = document.location.href
    this.previewInputTargets.forEach(input => {
      console.log(input.name)
      if (baseUrl.includes("?")) {
        this.url = `${baseUrl}&${input.name}=${input.value}`
      } else {
        this.url = `${baseUrl}?${input.name}=${input.value}`
      }
      fetch(this.url,
        { method: "GET",
          headers: { "Accept": "application/json" }
        })
        .then(response => response.json())
        .then(data => {
          console.log(document.getElementById(`preview-${input.name}`))
          document.getElementById(`preview-${input.name}`).innerText = `(${data})`
        })
    });
  }

}
