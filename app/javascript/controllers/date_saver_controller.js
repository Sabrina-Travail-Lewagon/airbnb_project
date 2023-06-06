import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-saver"
export default class extends Controller {
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
    };

  captureArrival(event) {
    const arrival = event.currentTarget.value;
    console.log(arrival);
    return arrival;
  };

  // var arrivee = captureArrival();

  captureDeparture(event2) {
    const departure = event2.currentTarget.value;
    console.log(departure);
    console.log(arrivee);
  };
};
