class MyFlatsController < ApplicationController
  def index
    @myflats = current_user.flats
  end

  def show
    @myflat = Flat.find(params[:id])
    @bookings = @myflat.bookings
  end
end
