import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "apartments", "secondRoomsInput", "secondSurfaceInput", "types", "groundFloor", "status", "sortPropositions" ]
  static values = { apartmentTypes: Array }

  connect() {
    this.apartmentTypes = this.apartmentTypesValue
  }

  // General methods

  hideAll() {
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

    this.element.submit()
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
    this.element.submit()
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
    this.element.submit()
  }

  // Surface

  changeSurface(event) {
    if (event.keyCode === 13 || event.currentTarget.value.length === 3) {
      if (this.secondSurfaceInputTarget.value !== "") {
        this.element.submit()
      } else {
        this.secondSurfaceInputTarget.select()
      }
    }
  }

  validSurface(event) {
    if (event.keyCode === 13 || event.currentTarget.value.length === 3) {
      this.element.submit()
    }
  }

  // Sort

  displaySort(event) {
    event.stopPropagation()
    this.sortPropositionsTarget.classList.toggle("d-none")
  }

}
