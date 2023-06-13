import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-saver"
export default class extends Controller {
  static targets = ["arrival", "departure", "total", "price", "guest"]

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
      // console.log("methode calcul total");
      // console.log(this.arrivalTarget.value);
      // console.log(this.departureTarget.value);
      // console.log(this.priceTarget.attributes.price.value);
      // console.log(this.totalTarget);

      if (this.arrivalTarget.value && this.departureTarget.value && this.guestTarget.value) {
        const arrivalDate = new Date(this.arrivalTarget.value);
        const departureDate = new Date(this.departureTarget.value);
        const pricePerNight = Number.parseInt(this.priceTarget.attributes.price.value, 10);
        const totalPlaceholder = this.totalTarget;
        const daysInMilliseconds = Math.abs(departureDate - arrivalDate);
        const totalDays = Math.ceil(daysInMilliseconds / (1000*60*60*24));
        const totalPrice = totalDays * pricePerNight;
        totalPlaceholder.innerHTML = `Total: ${pricePerNight}Є x ${totalDays} nuits = <span id="total-price">${totalPrice}Є</span>`;
        // totalPlaceholder.classList.remove("d-none")
        totalPlaceholder.style.opacity = 1;
      }
    };
  };
