class ApartmentsController < ApplicationController
  def index
    @apartments = Apartment.all

    filter_by_type
    filter_by_checkbox_criterias
    filter_by_radio_criterias
    ## rooms
    filter_by_rooms
    ## surface
    filter_by_surface
    ## location
    filter_by_locations

    respond_to do |format|
      format.html
      format.text { render partial: 'locations', locals: { locations: @results }, formats: :html }
    end
  end

  def show
    @apartment = Apartment.find(params[:id])
    @review = Review.new
  end

  private

  def filter_by_type
    if params[:flat].present? && params[:house].present?
      @apartments = @apartments.where(apartment_type: params[:flat]).or(@apartments.where(apartment_type: params[:house]))
    elsif params[:flat].present?
      @apartments = @apartments.where(apartment_type: params[:flat])
    elsif params[:house].present?
      @apartments = @apartments.where(apartment_type: params[:house])
    end
  end

  def filter_by_checkbox_criterias
    ## balcon
    @apartments = @apartments.where(balcony: true) if params[:balcony].present?
    ## cheminée
    @apartments = @apartments.where(chimney: true) if params[:chimney].present?
    ## ascenseur
    @apartments = @apartments.where(elevator: true) if params[:elevator].present?
    ## cellier
    @apartments = @apartments.where(cellar: true) if params[:cellar].present?
    ## parking
    @apartments = @apartments.where(parking: true) if params[:parking].present?
    ## terrasse
    @apartments = @apartments.where(terrace: true) if params[:terrace].present?
    ## jardin
    @apartments = @apartments.where(garden: true) if params[:garden].present?
  end

  def filter_by_radio_criterias
    # meublé / non meublé
    @apartments = @apartments.where("status ILIKE ? ", params[:status]) if params[:status].present?
  end

  def filter_by_rooms
    if params[:rooms_min].present? && params[:rooms_max].present? && params[:rooms_max].to_i >= params[:rooms_min].to_i
      @apartments = @apartments.where(rooms: params[:rooms_min].to_i..params[:rooms_max].to_i)
    elsif params[:rooms_min].present?
      @apartments = @apartments.where("rooms >= ? ", params[:rooms_min].to_i)
    elsif params[:rooms_max].present?
      @apartments = @apartments.where("rooms <= ? ", params[:rooms_max].to_i)
    end
  end

  def filter_by_surface
    if params[:surface_min].present? && params[:surface_max].present? && params[:surface_max].to_i >= params[:surface_min].to_i
      @apartments = @apartments.where(surface: params[:surface_min].to_i..params[:surface_max].to_i)
    elsif params[:surface_min].present?
      @apartments = @apartments.where("surface >= ? ", params[:surface_min].to_i)
    elsif params[:surface_max].present?
      @apartments = @apartments.where("surface <= ? ", params[:surface_max].to_i)
    end
  end

  def filter_by_locations
    @locations_insees = params[:locations].split(",") if params[:locations].present?
    if @locations_insees.present?
      @cities = City.where(insee_code: @locations_insees)
      @boroughs = Borough.where(insee_code: @locations_insees)
      @locations_tags = @cities + @boroughs
    end

    if @cities.present? && @boroughs.present?
      @apartments = (@apartments.where(city: @cities).or(@apartments.where(borough_id: @boroughs.map(&:id)))).uniq
    elsif @cities.present?
      @apartments = @apartments.where(city: @cities)
    elsif @boroughs.present?
      @apartments = @apartments.where(borough_id: @boroughs.map(&:id))
    end

    ## les resultats affichés
    @city_results = City.where("name ILIKE ? ", "%#{params[:search]}%") if params[:search].present?
    @city_results = @city_results.where.not(insee_code: @locations_insees) if @locations_insees.present? && @city_results.present?
    @borough_results = Borough.where("name ILIKE ? ", "%#{params[:search]}%") if params[:search].present?
    @borough_results = @borough_results.where.not(insee_code: @locations_insees) if @locations_insees.present? && @borough_results.present?
    @results = @city_results + @borough_results if @city_results.present? || @borough_results.present?
  end
end
