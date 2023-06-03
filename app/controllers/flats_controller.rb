class FlatsController < ApplicationController
  def index
    @flats = Flat.all
      if params[:search].present?
        @flats = Flat.search_by_title_and_address(params[:search])
        # @flats = @flats.where("title ILIKE ?", "%#{params[:search]}%")
      end
  end

  def show
    @flat = Flat.find(params[:id])
  end
end
