class FlatsController < ApplicationController
  def index
    # on définit par défaut toute la liste des flats quand la page charge
    @flats = Flat.all
    no_bookings_flats = []
    Flat.all.each { |flat| no_bookings_flats << flat if flat.bookings.empty? }
    # si l'utilisateur cherche seulement par mots clés, alors on lance la recherhce simple par mot clé
    if params[:search].present? && (params[:arrival].first == "" || params[:departure].first == "")
      @flats = Flat.search_by_title_and_address(params[:search])
    # si l'utilisateur cherche par mot clé et par date
    elsif params[:arrival].present? && params[:departure].present? && params[:search].present?
      # d'abord on cherche tous les appartement qui n'ont pas de bookings pendant les dates recherchées
      sql_subquery = <<~SQL
        :arrival <= bookings.date_arrival AND :arrival >= bookings.date_departure
        OR :departure >= bookings.date_departure AND :departure <= bookings.date_arrival
      SQL
      @flats = @flats.joins(:bookings).where.not(
        sql_subquery, arrival: params[:arrival], departure: params[:departure], search: params[:search]
        # puis on refiltre le résultat en fonction des mots clés entrés par l'utilisateur
      ).where("address ILIKE :query OR title ILIKE :query", query: "%#{params[:search]}%")
    # si l'utilisateur cherche par date on cherche tous les appartement qui n'ont pas de bookings pendant les dates recherchées
    elsif params[:arrival].present? && params[:departure].present?
      sql_subquery = <<~SQL
        :arrival >= bookings.date_arrival AND :arrival <= bookings.date_departure
        OR :departure <= bookings.date_departure AND :departure >= bookings.date_arrival
      SQL
      @flats = @flats.joins(:bookings).where.not(sql_subquery, arrival: params[:arrival], departure: params[:departure]).union(no_bookings_flats).uniq
    end
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
