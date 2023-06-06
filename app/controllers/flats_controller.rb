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
      category = Category.find_by(name: params["category_query"])
      @flats = Flat.joins(:flat_categories).where(flat_categories: { category_id: category.id })
    end
  end

  def show
    @user = current_user
    @flat = Flat.find(params[:id])
    # On créer une instance pour récupérer la première photo qui sera utilisée
    # pour la première image du caroussel (carouse-item active)
    @first_flat_photo = @flat.photos.first.key

    # On créer une liste avec les photos restantes, afin de pouvoir itérer sur
    # cette collection Active Storage
    @other_flats_photos = @flat.photos.drop(1)
  end

  def new
    @user = current_user
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    # On s'assure que le propriétaire du logement est l'utilisateur connecté
    @flat.owner = current_user
    # On va attacher les photos récupérées
    @flat.photos.attach(params[:flat][:photos])
    if @flat.save
      @flat.category_ids = params[:flat][:categories] # Associe les catégories sélectionnées
      @flat.equipment_ids = params[:flat][:equipments] # Associe les équipements sélectionnés
      raise
      redirect_to flat_path(@flat), notice: 'Le logement a été créé avec succès.'
    else
      render :new
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :description, :guest_nb, :price, :address, photos: [], category_ids: [], equipment_ids: [] )
  end

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
