class BookingsController < ApplicationController
  before_action :authenticate_user!
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @flat = Flat.find(params[:flat_id])
    @user = current_user
    @booking.flat = @flat
    @booking.customer = @user
    @booking.status = "Pending" # Par défaut tout booking est en attente
    if @booking.save
      redirect_to bookings_path
    else
      render flat_path(@flat), status: :unprocessable_entity
    end
  end

  def index
    @user = current_user
    @bookings = @user.bookings
    # Equivalent à la ligne du dessous :
    # @bookings = Booking.where(customer: @user)
  end

  def approved
    @booking = Booking.find(params[:id])
    @booking.status = "Approved"
    if @booking.save
      redirect_to my_flat_path(@booking.flat)
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date_arrival, :date_departure, :traveler_nb, :total)
  end
end
