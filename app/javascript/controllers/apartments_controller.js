import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "apartments", "secondRoomsInput", "secondSurfaceInput", "reviews"]
  static values = { reviews: Array }

  connect() {
    console.log(this.reviewsValue)
    this.reviewsTarget.value = this.reviewsValue
  }


  change() {
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
      .then(text => this.apartmentsTarget.innerHTML = text)
  }
}
