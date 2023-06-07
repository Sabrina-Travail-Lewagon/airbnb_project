import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {

  static targets = [ "dateArrival", "dateDeparture" ]

  connect() {
    console.log("test flatpickr stim");

    flatpickr(this.dateArrivalTarget, {
      altInput: true,
      altFormat: "j F, Y",
      dateFormat: "Y-m-d",
      minDate: "today"
    });
    // const date = this.dateArrivalTarget.value;
    // console.log(date);

    flatpickr(this.dateDepartureTarget, {
      altInput: true,
      altFormat: "j F, Y",
      dateFormat: "Y-m-d",
      minDate: "today"
    });
  };
}
