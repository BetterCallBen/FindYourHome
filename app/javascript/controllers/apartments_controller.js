import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "secondSurfaceInput", "sortPropositions", "form" ]

  // General methods

  hideAll() {
    this.sortPropositionsTarget.classList.add("d-none")
  }

  submitForm() {
    this.formTarget.submit()
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
      this.submitForm()
    }
  }

  // Sort

  displaySort(event) {
    event.stopPropagation()
    this.sortPropositionsTarget.classList.toggle("d-none")
  }

}
