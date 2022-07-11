import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "apartments", "secondRoomsInput", "secondSurfaceInput", "types", "groundFloor", "status", "sortPropositions", "minRooms", "minRoomsPropositions", "maxRoomsPropositions", "minRoomsInput" ]
  static values = { apartmentTypes: Array }

  connect() {
    this.apartmentTypes = this.apartmentTypesValue
  }

  // General methods

  hideAll() {
    console.log("hide")
    this.minRoomsPropositionsTarget.classList.add("d-none")
    this.maxRoomsPropositionsTarget.classList.add("d-none")
    this.sortPropositionsTarget.classList.add("d-none")
  }

  submitForm() {
    this.element.submit()
  }

  resetForm() {
    window.location = document.location.pathname
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
      this.submitForm()
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
      this.submitForm()
    }
  }

  // Surface

  changeSurface(event) {
    if (event.keyCode === 13 || event.currentTarget.value.length === 3) {
      if (this.secondSurfaceInputTarget.value !== "") {
        this.submitForm()
      } else {
        this.secondSurfaceInputTarget.select()
      }
    }
  }

  validSurface(event) {
    if (event.keyCode === 13 || event.currentTarget.value.length === 3) {
      this.submitForm()
    }
  }

  // Sort

  displaySort(event) {
    event.stopPropagation()
    this.sortPropositionsTarget.classList.toggle("d-none")
  }

}
