import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = []
  static values = {}


  addFavorite(event) {
    const target = event.currentTarget
    const type = event.currentTarget.dataset.type
    const propertyId = event.currentTarget.dataset.propertyId
    console.log(propertyId)
    const html = `<div data-action="click->favorite#removeFavorite" data-property-id="${propertyId}" data-type="${type}">
                    <div class="apartment-fav">
                      <i class="fa-solid fa-heart active"></i>
                    </div>
                  </div>`
    fetch(`/${type}/${propertyId}/add_favorite`, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken(),
      }
    })
    .then(response => response.json())
    .then(data => {
      target.outerHTML = html
    })
  }

  removeFavorite(event) {
    const target = event.currentTarget
    const propertyId = event.currentTarget.dataset.propertyId
    const type = event.currentTarget.dataset.type
    const html = `<div data-action="click->favorite#addFavorite" data-property-id="${propertyId}" data-type="${type}">
                    <div class="apartment-fav">
                      <i class="fa-solid fa-heart"></i>
                    </div>
                  </div>`
    fetch(`/${type}/${propertyId}/remove_favorite`, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken(),
      }
    })
    .then(response => response.json())
    .then(data => {
      target.outerHTML = html
    })
  }
}
