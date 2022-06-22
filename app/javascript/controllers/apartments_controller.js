import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "apartments", "secondRoomsInput", "secondSurfaceInput", "locations", "locationResults"]
  static values = { locations: Array }

  connect() {
    this.locationIds = this.locationsValue
    this.locationIdsArray = this.locationIds[0]
  }


  searchLocations(event) {
    const baseUrl = document.location.href
    if (baseUrl.includes("?")) {
      this.url = `${baseUrl}&search=${event.currentTarget.value}`
    } else {
      this.url = `${baseUrl}?search=${event.currentTarget.value}`
    }
    fetch(this.url,
      { method: "GET",
        headers: { "Accept": "text/plain" }
      })
      .then(response => response.text())
      .then(text => this.locationResultsTarget.innerHTML = text)
  }

  addLocation(event) {
    this.locationIds.push(event.currentTarget.dataset.id)
    this.locationsTarget.value = this.locationIds
    this.submitForm()
  }

  removeLocation(event) {
    const index = this.locationIdsArray.indexOf(parseInt(event.currentTarget.dataset.id))
    if (index > -1) {
      this.locationIdsArray.splice(index, 1)
    }
    this.locationsTarget.value = this.locationIdsArray
    this.submitForm()
  }



  submitForm() {
    this.formTarget.submit()
  }

  changeRooms(event) {
    if (event.currentTarget.value !== "" || event.keyCode === 13) {
      if (this.secondRoomsInputTarget.value !== "") {
        this.formTarget.submit()
      } else {
        this.secondRoomsInputTarget.select()
      }
    }
  }

  validRooms(event) {
    if (event.currentTarget.value !== "" || event.keyCode === 13) {
      this.formTarget.submit()
    }
  }

  changeSurface(event) {
    if (event.keyCode === 13 || event.currentTarget.value.length === 3) {
      if (this.secondSurfaceInputTarget.value !== "") {
        this.formTarget.submit()
      } else {
        this.secondSurfaceInputTarget.select()
      }
    }
  }

  validSurface(event) {
    if (event.keyCode === 13 || event.currentTarget.value.length === 3) {
      this.formTarget.submit()
    }
  }

  search(event) {


    fetch(this.url,
      { method: "GET",
        headers: { "Accept": "text/plain" }
      })
      .then(response => response.text())
      .then(text => this.apartmentsTarget.innerHTML = text)
  }
}
