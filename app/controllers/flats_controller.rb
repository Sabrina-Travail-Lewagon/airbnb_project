class FlatsController < ApplicationController
  def index
    @flats = Flat.all
    @categories = Category.all
    if params["category_query"]
      # On va chercher la catégorie dans le model Category
      category = Category.where(name: params["category_query"])
      # On récupère la liste des flats dans flat_category
      flats_list = FlatCategory.where(category: category)
      # On va retrouver la liste des flats dans le model Flat
      @flats = Flat.where(id: flats_list)
    end
  end

  def show
    @flat = Flat.find(params[:id])
  end
end
