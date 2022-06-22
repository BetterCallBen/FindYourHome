import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "apartments", "secondRoomsInput", "secondSurfaceInput", "reviews", "reviewsInputs"]
  static values = { reviews: Array }

  searchReviews(event) {
    console.log(event.currentTarget.value)
    fetch(`/apartments?search=${event.currentTarget.value}`,
      { method: "GET",
        headers: { "Accept": "text/plain" }
      })
      .then(response => response.text())
      .then(text => this.reviewsInputsTarget.innerHTML = text)
  }

  addReview(event) {
    const reviewIds = this.reviewsValue
    console.log(event.currentTarget.dataset.id)
    reviewIds.push(event.currentTarget.dataset.id)
    this.reviewsTarget.value = reviewIds
    this.submitForm()
  }


  submitForm() {
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
