import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "secondSurfaceInput", "sortPropositions", "form", "burger" ]

  // General methods

  hideAll() {
    this.sortPropositionsTarget.classList.add("d-none")
    this.burgerTarget.classList.remove("cross")
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
      this.formTarget.submit()
    }
  }

  // Sort

  displaySort(event) {
    event.stopPropagation()
    this.burgerTarget.classList.toggle("cross")
    console.log(this.burgerTarget.classList.contains("cross"));
    this.burgerTarget.classList.toggle("active", !this.burgerTarget.classList.contains("cross"))
    this.sortPropositionsTarget.classList.toggle("hidden")
    this.sortPropositionsTarget.classList.remove("d-none")

  }

}
