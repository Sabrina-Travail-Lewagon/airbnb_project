import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map-show"
export default class extends Controller {
  static targets = ["grid", "map", "button"]

  toggle() {
    if (this.mapTarget.classList.contains("d-none")) {
      console.log("carte afficher")
      this.mapTarget.classList.remove("d-none");
      this.gridTarget.classList.add("d-none");
      this.buttonTarget.innerText = 'Afficher la grille';
    } else {
      console.log("Carte cacher")
      this.mapTarget.classList.add("d-none");
      this.gridTarget.classList.remove("d-none");
      this.buttonTarget.innerText = "Afficher la carte";
    }
  }
}
