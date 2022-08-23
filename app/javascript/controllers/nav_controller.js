import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["menu"]
  static values = {}

  displayMenu(event) {
    event.stopPropagation()
    event.currentTarget.classList.add("active")
    this.menuTarget.classList.add("active")
  }

  dontHideMenu(event) {
    event.stopPropagation()
  }

  hideMenu(event) {
    event.currentTarget.classList.remove("active")
    this.menuTarget.classList.remove("active")
  }

}
