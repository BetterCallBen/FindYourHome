import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ["notification"]
  static values = {}


  addFavorite(event) {
    const target = event.currentTarget
    const type = event.currentTarget.dataset.type
    const propertyId = event.currentTarget.dataset.propertyId
    const html = `<div data-action="click->favorite#removeFavorite" data-property-id="${propertyId}" data-type="${type}">
                    <div class="favorite-heart">
                      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="heart-icon active">
                        <path d="M11.645 20.91l-.007-.003-.022-.012a15.247 15.247 0 01-.383-.218 25.18 25.18 0 01-4.244-3.17C4.688 15.36 2.25 12.174 2.25 8.25 2.25 5.322 4.714 3 7.688 3A5.5 5.5 0 0112 5.052 5.5 5.5 0 0116.313 3c2.973 0 5.437 2.322 5.437 5.25 0 3.925-2.438 7.111-4.739 9.256a25.175 25.175 0 01-4.244 3.17 15.247 15.247 0 01-.383.219l-.022.012-.007.004-.003.001a.752.752 0 01-.704 0l-.003-.001z" />
                      </svg>
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
      console.log(data)
      if (data.error) {
        const notif = `<div class="alert error" data-controller="notice" data-favorite-target="notification">
                        ${data.error}
                        <i class="fa-solid fa-xmark" data-action="click->notice#close"></i>
                      </div>`
        this.notificationTargets.forEach(notification => {
          notification.remove()
        })
        this.element.insertAdjacentHTML("afterbegin", notif)
      } else {
        target.outerHTML = html
        const notif = `<div class="alert success" data-controller="notice" data-favorite-target="notification">
                        ${data.message}
                          <i class="fa-solid fa-xmark" data-action="click->notice#close"></i>
                        </div>`
        this.notificationTargets.forEach(notification => {
          notification.remove()
        })
        this.element.insertAdjacentHTML("afterbegin", notif)
      }
    })
  }

  removeFavorite(event) {
    const target = event.currentTarget
    const propertyId = event.currentTarget.dataset.propertyId
    const type = event.currentTarget.dataset.type
    const html = `<div data-action="click->favorite#addFavorite" data-property-id="${propertyId}" data-type="${type}">
                    <div class="favorite-heart">
                      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="heart-icon">
                        <path d="M11.645 20.91l-.007-.003-.022-.012a15.247 15.247 0 01-.383-.218 25.18 25.18 0 01-4.244-3.17C4.688 15.36 2.25 12.174 2.25 8.25 2.25 5.322 4.714 3 7.688 3A5.5 5.5 0 0112 5.052 5.5 5.5 0 0116.313 3c2.973 0 5.437 2.322 5.437 5.25 0 3.925-2.438 7.111-4.739 9.256a25.175 25.175 0 01-4.244 3.17 15.247 15.247 0 01-.383.219l-.022.012-.007.004-.003.001a.752.752 0 01-.704 0l-.003-.001z" />
                      </svg>
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
      const notif = `<div class="alert success" data-controller="notice" data-favorite-target="notification">
                      ${data.message}
                        <i class="fa-solid fa-xmark" data-action="click->notice#close" ></i>
                      </div>`
      this.notificationTargets.forEach(notification => {
        notification.remove()
      })
      this.element.insertAdjacentHTML("afterbegin", notif)
    })
  }
}
