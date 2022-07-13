import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["bedrooms", "filling", "filling1", "filling2", "filling3", "filling4"]
  static values = { bedrooms: Array }

  connect() {
    this.bedrooms = this.bedroomsValue.map(bedroom => parseInt(bedroom));
    console.log(this.bedrooms);
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

    this.fillingTargets.forEach(filling => {
      const fillingValue = parseInt(filling.dataset.value)
      if (this.bedrooms.includes(fillingValue) && this.bedrooms.includes(fillingValue + 1)) {
        filling.classList.add("active")
      } else {
        filling.classList.remove("active")
      }
    });

  }

  tata() {
    this.bedroomsTarget.value = this.bedrooms
    this.element.submit()
  }
  }
