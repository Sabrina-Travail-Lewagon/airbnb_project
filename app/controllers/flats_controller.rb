class FlatsController < ApplicationController
  def index
    # on définit par défaut toute la liste des flats quand la page charge
    @flats = Flat.all
    @categories = Category.all
    # si l'utilisateur cherche seulement par mots clés, alors on lance la recherhce simple par mot clé
    if params[:search].present? && (params[:arrival].first == "" || params[:departure].first == "")
      @flats = Flat.search_by_title_and_address(params[:search])
    # si l'utilisateur cherche par mot clé et par date
    elsif params[:arrival].present? && params[:departure].present? && params[:search].present?
      # d'abord on cherche tous les appartement qui n'ont pas de bookings pendant les dates recherchées
      all_params_query
    # si l'utilisateur cherche par date on cherche tous les appartement qui n'ont pas de bookings pendant les dates recherchées
    elsif params[:arrival].present? && params[:departure].present?
      date_params_query
    end

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
    @booking = Booking.new
  end

  private

  def empty_flats
    if params[:search].present?
      Flat.where.missing(:bookings).where(
        "address ILIKE :query OR title ILIKE :query", query: "%#{params[:search]}%"
      ).to_a
    else
      Flat.where.missing(:bookings).to_a
    end
  end

  def all_params_query
    # on prépare une query ne prenant que les bookings dont les dates ne se chevauchent pas avec les dates recherchées
    sql_subquery = <<~SQL
      :arrival <= bookings.date_arrival AND :arrival >= bookings.date_departure
      OR :departure >= bookings.date_departure AND :departure <= bookings.date_arrival
    SQL
    # on charge la query dans active record pour l'appliquer aux flats
    @flats = @flats.joins(:bookings).where.not(
      sql_subquery, arrival: params[:arrival], departure: params[:departure], search: params[:search]
      # puis on refiltre le résultat en fonction des mots clés entrés par l'utilisateur
    ).where("address ILIKE :query OR title ILIKE :query", query: "%#{params[:search]}%").to_a.union(empty_flats)
    # le union sert à rajouter aux flats filtrer les flats ne possédant pas de bookings
  end

  def date_params_query
    sql_subquery = <<~SQL
      :arrival >= bookings.date_arrival AND :arrival <= bookings.date_departure
      OR :departure <= bookings.date_departure AND :departure >= bookings.date_arrival
    SQL
    @flats = @flats.joins(:bookings).where.not(
      sql_subquery, arrival: params[:arrival], departure: params[:departure]
    ).to_a.union(empty_flats)
  end
end
