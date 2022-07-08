import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "apartments", "secondRoomsInput", "secondSurfaceInput", "locations", "locationResults", "types", "groundFloor", "status"]
  static values = { locationInsees: Array, apartmentTypes: Array }

  connect() {
    this.locationInsees = this.locationInseesValue
    this.apartmentTypes = this.apartmentTypesValue
  }

  toggleType(event) {
    const type = event.currentTarget.value

    if (this.apartmentTypes.includes(type)) {
      const index = this.apartmentTypes.indexOf(type)
      if (index > -1) {
        this.apartmentTypes.splice(index, 1)
      }
    } else {
      this.apartmentTypes.push(type)
    }
    this.typesTarget.value = this.apartmentTypes

    this.submitForm()
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
    this.locationInsees.push(event.currentTarget.dataset.inseeCode)
    this.locationsTarget.value = this.locationInsees

    this.submitForm()
  }

  removeLocation(event) {
    const inseeCode = event.currentTarget.dataset.inseeCode
    const index = this.locationInsees.indexOf(inseeCode)
    if (index > -1) {
      this.locationInsees.splice(index, 1)
    }
    this.locationsTarget.value = this.locationInsees
    this.submitForm()
  }





  submitForm() {
    this.formTarget.submit()
  }

  toggleGroundFloor(event) {
    if (!event.target.checked) {
      this.groundFloorTargets.forEach(groundFloor => {
        groundFloor.checked = false
      });
    } else {
      this.groundFloorTargets.forEach(groundFloor => {
        groundFloor.checked = false
      });
      event.target.checked = true
    }
    this.submitForm()
  }

  toggleStatus(event) {
    if (!event.target.checked) {
      this.statusTargets.forEach(status => {
        status.checked = false
      });
    } else {
      this.statusTargets.forEach(status => {
        status.checked = false
      });
      event.target.checked = true
    }
    this.submitForm()
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

  resetForm() {
    window.location = document.location.pathname
  }
}
