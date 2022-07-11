import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["locations", "locationResults"]
  static values = { insees: Array }

  connect() {
    this.insees = this.inseesValue
  }

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
        this.locationResultsTarget.innerHTML = ""
      }

    }, 200);

  }

  addLocation(event) {
    this.insees.push(event.currentTarget.dataset.inseeCode)
    this.locationsTarget.value = this.insees

    this.submitForm()
  }

  removeLocation(event) {
    const inseeCode = event.currentTarget.dataset.inseeCode
    const index = this.insees.indexOf(inseeCode)
    if (index > -1) {
      this.insees.splice(index, 1)
    }
    this.locationsTarget.value = this.insees
    this.submitForm()
  }
}
