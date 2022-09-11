import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["marker", "map"]
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()

  }

  #addMarkersToMap() {

    for (const marker of this.markersValue) {

      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.partial

      const popup = new mapboxgl.Popup().setHTML(marker.info_window)

      popup.on('open', () => {
        const activeMarker = document.querySelector(`#marker${marker.id}`)
        activeMarker.classList.add("active")
      });

      popup.on('close', () => {
        const activeMarker = document.querySelector(`#marker${marker.id}`)
        if (activeMarker) {
          activeMarker.classList.remove("active")
        }
      });

      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    }
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 150, maxZoom: 15, duration: 0 })
  }

  showMarker(event) {
    const markerId = event.currentTarget.dataset.markerId
    const marker = document.querySelector(`#marker${markerId}`)
    marker.classList.add("active")
  }

  hideMarker(event) {
    const markerId = event.currentTarget.dataset.markerId
    const marker = document.querySelector(`#marker${markerId}`)
    marker.classList.remove("active")
  }
}
