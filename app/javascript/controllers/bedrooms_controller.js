import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["bedrooms", "rooms", "roomFilling", "roomFilling1", "roomFilling2", "roomFilling3", "roomFilling4", "bedroomFilling", "bedroomFilling1", "bedroomFilling2", "bedroomFilling3", "bedroomFilling4"]
  static values = { bedrooms: Array, rooms: Array }

  connect() {
    this.bedrooms = this.bedroomsValue.map(bedroom => parseInt(bedroom));
    this.rooms = this.roomsValue.map(room => parseInt(room));
  }

  selectBedroom(event) {
    const targetValue = parseInt(event.target.value)
    if (this.bedrooms.includes(targetValue)) {
      const index = this.bedrooms.indexOf(targetValue)
      if (index > -1) {
        this.bedrooms.splice(index, 1)
      }
    } else {
      this.bedrooms.push(targetValue)
    }

    this.bedroomFillingTargets.forEach(filling => {
      const fillingValue = parseInt(filling.dataset.value)
      if (this.bedrooms.includes(fillingValue) && this.bedrooms.includes(fillingValue + 1)) {
        filling.classList.add("active")
      } else {
        filling.classList.remove("active")
      }
    });

  }

  selectRoom(event) {
    const targetValue = parseInt(event.target.value)
    if (this.rooms.includes(targetValue)) {
      const index = this.rooms.indexOf(targetValue)
      if (index > -1) {
        this.rooms.splice(index, 1)
      }
    } else {
      this.rooms.push(targetValue)
    }

    this.roomFillingTargets.forEach(filling => {
      const fillingValue = parseInt(filling.dataset.value)
      if (this.rooms.includes(fillingValue) && this.rooms.includes(fillingValue + 1)) {
        filling.classList.add("active")
      } else {
        filling.classList.remove("active")
      }
    });
    console.log(this.roomsTarget.value);

  }

  valid() {
    this.bedroomsTarget.value = this.bedrooms
    this.roomsTarget.value = this.rooms

    this.element.submit()
  }
  }
