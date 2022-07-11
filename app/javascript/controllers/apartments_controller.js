import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "apartments", "secondRoomsInput", "secondSurfaceInput", "locations", "locationResults", "types", "groundFloor", "status", "sortPropositions", "minRooms", "minRoomsPropositions", "maxRoomsPropositions", "minRoomsInput" ]
  static values = { locationInsees: Array, apartmentTypes: Array }

  connect() {
    this.locationInsees = this.locationInseesValue
    this.apartmentTypes = this.apartmentTypesValue
  }

  // General methods

  hideAll() {
    console.log("hide")
    this.minRoomsPropositionsTarget.classList.add("d-none")
    this.maxRoomsPropositionsTarget.classList.add("d-none")
    this.sortPropositionsTarget.classList.add("d-none")
    this.locationResultsTarget.classList.add("d-none")
  }

  submitForm() {
    this.formTarget.submit()
  }

  resetForm() {
    window.location = document.location.pathname
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

  // Apartment types

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

  // Floors

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

  // Status

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

  // Rooms

  MinToMaxRooms() {
    if (this.secondRoomsInputTarget.value !== "") {
      this.formTarget.submit()
    } else {
      this.secondRoomsInputTarget.select()
    }
    this.minRoomsPropositionsTarget.classList.add("d-none")
    this.maxRoomsPropositionsTarget.classList.remove("d-none")
  }

  displayMinPropositions(event) {
    event.stopPropagation()
    this.minRoomsPropositionsTarget.classList.remove("d-none")
    this.maxRoomsPropositionsTarget.classList.add("d-none")
  }

  displayMaxPropositions(event) {
    event.stopPropagation()
    this.maxRoomsPropositionsTarget.classList.remove("d-none")
    this.minRoomsPropositionsTarget.classList.add("d-none")
  }

  selectMinRooms(event) {
    event.stopPropagation()
    this.minRoomsInputTarget.value = event.target.value
    if (this.minRoomsInputTarget.value !== "" || event.keyCode === 13) {
      this.MinToMaxRooms()
    }
  }

  selectMaxRooms(event) {
    this.secondRoomsInputTarget.value = event.target.value
    if (this.secondRoomsInputTarget.value !== "" || event.keyCode === 13) {
      this.formTarget.submit()
    }
  }

  // Surface

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

  // Sort

  displaySort(event) {
    event.stopPropagation()
    this.sortPropositionsTarget.classList.toggle("d-none")
  }

}
