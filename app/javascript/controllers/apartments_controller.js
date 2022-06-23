import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "apartments", "secondRoomsInput", "secondSurfaceInput", "locations", "locationResults"]
  static values = { locations: Array }

  connect() {
    this.locationInsees = this.locationsValue
    this.locationInseesArray = this.locationInsees[0]
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
    console.log(event.currentTarget.dataset.inseeCode)
    this.locationInsees.push(event.currentTarget.dataset.inseeCode)
    this.locationsTarget.value = this.locationInsees
    this.submitForm()
  }

  removeLocation(event) {
    const inseeCode = event.currentTarget.dataset.inseeCode
    const index = this.locationInseesArray.indexOf(inseeCode)
    if (index > -1) {
      this.locationInseesArray.splice(index, 1)
    }
    this.locationsTarget.value = this.locationInseesArray
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
