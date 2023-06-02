class FlatsController < ApplicationController
  def index
    @flats = Flat.all
    @categories = Category.all

  end

  def show
    @flat = Flat.find(params[:id])
  end
end
