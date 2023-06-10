import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-saver"
export default class extends Controller {
  static targets = ["arrival", "departure", "total", "price"]

  connect() {
    console.log("test date saver stim");
    // let arrival = document.querySelector("#booking_date_arrival");
    // if (arrival) {
    //   arrival.addEventListener("input", (event) => {
    //     let arrivalDate = event.currentTarget["value"];
    //   });
    // }

    // let departure = document.querySelector("#booking_date_departure");
    // if (departure) {
    //   departure.addEventListener("input", (event2) => {
    //     let departureDate = event2.currentTarget["value"];
    //     console.log(arrivalDate);
    //     console.log(departureDate);
    //     let arrivalString = new Date('${arrivalDate}');
    //     console.log(arrivalString);
    //     let departureString = new Date('${departure}');
    //     console.log(departureString);
    //     let nights = departureString - arrivalString;
    //     console.log(nights);
    //   });
    // console.log(this.arrivalTarget.value)

    // if (this.arrivalTarget.value) {
    //   console.log("ok")
    // }
    // console.log(this.priceTarget.innerText);
    };

  calculTotal() {
    console.log("calcul total");
    if (this.arrivalTarget.value && this.departureTarget.value) {
      let arrivalDate = new Date(this.arrivalTarget.value);
      let departureDate = new Date(this.departureTarget.value);
      // console.log(arrivalDate);
      // console.log(departureDate);
      let totalDays = Math.abs(departureDate-arrivalDate);
      const days = Math.ceil(totalDays/(1000*60*60*24));
      // console.log(days);
      console.log(this.priceTarget)
      // let price = Number.parseInt(this.priceTarget.price, 10);
      // console.log(price);
    }
  };
};
