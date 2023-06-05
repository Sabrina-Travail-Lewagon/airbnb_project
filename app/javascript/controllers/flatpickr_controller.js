import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {

  static targets = [ "dateArrival", "dateDeparture" ]


  connect() {
    flatpickr(this.dateArrivalTarget, {
      altInput: true,
      altFormat: "j F, Y",
      dateFormat: "Y-m-d",
      enableTime: true,
      minDate: "today"
    });
    flatpickr(this.dateDepartureTarget, {
      altInput: true,
      altFormat: "j F, Y",
      dateFormat: "Y-m-d",
      enableTime: true,
      minDate: "today"
    });
  }
}
