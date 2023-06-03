class FlatsController < ApplicationController
  def index
    @flats = Flat.all
    @categories = Category.all
    if params["category_query"]
      category = Category.where(name: params["category_query"])
      @flats = Flat.where(category_id: category.ids)
    end
  end

  def show
    @flat = Flat.find(params[:id])
  end
end
