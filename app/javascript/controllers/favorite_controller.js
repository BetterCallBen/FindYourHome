import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []
  static values = {}

  connect() {
    console.log("toto")
  }

  submitForm() {
    this.element.submit()
  }

}
