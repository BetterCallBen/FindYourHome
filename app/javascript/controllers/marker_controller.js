import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []
  static values = {}

  activeMarker(event) {
    const marker = event.currentTarget
    marker.classList.add("active")
  }
}
