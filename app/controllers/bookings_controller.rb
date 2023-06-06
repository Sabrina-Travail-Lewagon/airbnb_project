class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @flat = Flat.find(params[:flat_id])
    @user = current_user
    @booking.flat = @flat
    @booking.customer = @user
    @booking.save
    redirect_to flat_path(@flat)
  end

  def show
    @user = current_user
    @bookings = Booking.where(customer: @user)
  end

  private

  def booking_params
    params.require(:booking).permit(:date_arrival, :date_departure, :traveler_nb, :total)
  end
end
