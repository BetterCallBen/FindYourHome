class ApartmentsController < ApplicationController
  def index
    @apartments = Apartment.all

    filter_by_project
    filter_by_checkbox_criterias
    filter_by_radio_criterias
    filter_by_rooms
    filter_by_surface
    filter_by_apartment_type
    filter_by_locations

    if params[:locations].present? && params[:locations].split(",").count == 1
      insee_code = params[:locations].split(",").first
      borough = Borough.find_by(insee_code: insee_code)
      city = City.find_by(insee_code: insee_code)
      @location = borough || city
      @there = "à #{@location.name}"
    end

    if params[:types].present? && params[:types].split(",").count == 1
      @what = params[:types].split(",").first
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'locations', locals: { locations: @results }, formats: :html }
    end
  end

  def show
    @apartment = Apartment.find(params[:id])
  end

  private

  def filter_by_project
    @apartments = @apartments.where(project: params[:project]) if params[:project].present?
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

  def filter_by_apartment_type
    @apartment_types = params[:types].split(",") if params[:types].present?

    @apartments = @apartments.where(apartment_type: @apartment_types) if @apartment_types.present?
  end

  def filter_by_locations
    @locations_insees = params[:locations].split(",") if params[:locations].present?

    find_location_tags if @locations_insees.present?

    filter_the_apartment

    ## les resultats affichés
    return unless params[:search].present?

    find_results
  end

  def find_location_tags
    @cities = City.where(insee_code: @locations_insees)
    @boroughs = Borough.where(insee_code: @locations_insees)
    @locations_tags = @cities + @boroughs
  end

  def filter_the_apartment
    if @cities.present? && @boroughs.present?
      @apartments = @apartments.where(city: @cities).or(@apartments.where(borough_id: @boroughs.map(&:id))).uniq
    elsif @cities.present?
      @apartments = @apartments.where(city: @cities)
    elsif @boroughs.present?
      @apartments = @apartments.where(borough_id: @boroughs.map(&:id))
    end
  end

  def find_results
    @city_results = City.where("name ILIKE ? ", "%#{params[:search]}%")
    if @locations_insees.present? && @city_results.present?
      @city_results = @city_results.where.not(insee_code: @locations_insees)
    end
    @borough_results = Borough.where("name ILIKE ? ", "%#{params[:search]}%")
    if @locations_insees.present? && @borough_results.present?
      @borough_results = @borough_results.where.not(insee_code: @locations_insees)
    end
    @results = @city_results + @borough_results if @city_results.present? || @borough_results.present?
  end
end
