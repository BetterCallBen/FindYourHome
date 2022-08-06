import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = []
  static values = {}


  addFavorite(event) {
    const target = event.currentTarget
    const apartmentId = event.currentTarget.dataset.apartmentId
    const html = `<div data-action="click->favorite#removeFavorite" data-apartment-id="${apartmentId}">
                    <div class="apartment-fav">
                      <i class="fa-solid fa-heart active"></i>
                    </div>
                  </div>`
    fetch(`/apartments/${apartmentId}/add_favorite`, {
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
    const apartmentId = event.currentTarget.dataset.apartmentId
    const target = event.currentTarget
    const html = `<div data-action="click->favorite#addFavorite" data-apartment-id="${apartmentId}">
                <div class="apartment-fav">
                  <i class="fa-solid fa-heart"></i>
                </div>
              </div>`
    fetch(`/apartments/${apartmentId}/remove_favorite`, {
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
