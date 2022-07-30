import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["locations", "locationResults"]

  hideLocations() {
    this.locationResultsTarget.classList.add("d-none")
  }

  submitForm() {
    this.element.submit()
  }

  // Locations

  displayLocations(event) {
    event.stopPropagation()
    this.locationResultsTarget.classList.remove("d-none")
  }

  searchLocations(event) {

    clearTimeout(this.searching)

    this.searching = setTimeout(() => {

      if (event.target.value.length > 0) {

        const baseUrl = document.location.href
        if (baseUrl.includes("?")) {
          this.url = `${baseUrl}&search=${event.target.value}`
        } else {
          this.url = `${baseUrl}?search=${event.target.value}`
        }
        fetch(this.url,
          { method: "GET",
            headers: { "Accept": "text/plain" }
          })
          .then(response => response.text())
          .then(locations => this.locationResultsTarget.innerHTML = locations)

      } else {
        if (this.insees.length > 0) {
          const html =
              `<div class="placehold">
                <p>Saisissez une ville ou un arrondissement</p>
              </div>`
          this.locationResultsTarget.innerHTML = html
        } else {
          this.locationResultsTarget.innerHTML = ""
        }
      }

    }, 200);

  }
}
