import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["filling", "filling1", "filling2", "filling3", "filling4"]
  static values = {}

  connect() {
    console.log("coucou toi")
    this.bedrooms = []
  }

  // General methods

  submitForm() {
    this.element.submit()
  }

  toto(event) {
    const targetValue = parseInt(event.target.value)
    if (this.bedrooms.includes(targetValue)) {
      const index = this.bedrooms.indexOf(targetValue)
      if (index > -1) {
        this.bedrooms.splice(index, 1)
      }
    } else {
      this.bedrooms.push(targetValue)
    }
    console.log(this.bedrooms)
    this.fillingTargets.forEach(filling => {
      const fillingValue = parseInt(filling.dataset.value)
      if (this.bedrooms.includes(fillingValue) && this.bedrooms.includes(fillingValue + 1)) {
        console.log("good")
        filling.classList.add("active")
      } else {
        filling.classList.remove("active")
      }
    });
  }
}
