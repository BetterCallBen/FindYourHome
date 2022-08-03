import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = []
  static values = {}

  addFavorite(event) {
    event.preventDefault()
    const favoriteApartmentId = event.currentTarget.dataset.favoriteApartmentId;
    const target = event.currentTarget;
    const apartmentId = event.currentTarget.dataset.apartmentId;
    const url = `/favorite_apartments`;
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken(),
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({
        favorite_apartment: {
          apartment_id: apartmentId
        }
      })

    })
  }

  removeFavorite(event) {
    event.preventDefault()
    const favoriteApartmentId = event.currentTarget.dataset.favoriteApartmentId;
    const url = `/favorite_apartments/${favoriteApartmentId}`;
    fetch(url, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": csrfToken(),
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
    })

  }

}
