class PagesController < ApplicationController
  def home
    redirect_to properties_path
  end

  def index
    @apartments = Apartment.includes(:city, :borough)
    @houses = House.includes(:city, :borough)

    filter_by_checkbox_criterias
    filter_by_status
    filter_by_floor
    filter_by_rooms
    filter_by_surface
    filter_by_locations
    filter_by_apartment_type
    filter_by_project

    @what = params[:types].split(",").first if params[:types].present? && params[:types].split(",").count == 1

    @properties = (@apartments + @houses).uniq

    if params[:sort].present?
      case params[:sort]
      when "Prix"
        @properties = @properties.sort_by(&:price)
      when "Surface"
        @properties = @properties.sort_by(&:surface)
      when "Pertinence"
        @properties = @properties.shuffle
      end
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'locations', locals: { locations: @results }, formats: :html }
      format.json { render json: @properties.count }
    end
  end

  private

  def filter_by_project
    return unless params[:project].present?

    @apartments = @apartments.where(project: params[:project])
    @houses = @houses.where(project: params[:project])
  end

  def filter_by_checkbox_criterias
    ## balcon
    if params[:balcony].present?
      @apartments = @apartments.where(balcony: true)
      @houses = @houses.where(balcony: true)
    end
    ## cheminée
    if params[:chimney].present?
      @apartments = @apartments.where(chimney: true)
      @houses = @houses.where(chimney: true)
    end
    ## ascenseur
    @apartments = @apartments.where(elevator: true) if params[:elevator].present?
    ## cellier
    if params[:cellar].present?
      @apartments = @apartments.where(cellar: true)
      @houses = @houses.where(cellar: true)
    end
    ## garage
    if params[:garage].present?
      @apartments = @apartments.where(garage: true)
      @houses = @houses.where(garage: true)
    end
    ## terrasse
    if params[:terrace].present?
      @apartments = @apartments.where(terrace: true)
      @houses = @houses.where(terrace: true)
    end
    ## jardin
    @houses = @houses.where(garden: true) if params[:garden].present?
    ## piscine
    @houses = @houses.where(pool: true) if params[:pool].present?
  end

  def filter_by_status
    # meublé / non meublé
    @apartments = @apartments.where("status ILIKE ? ", params[:status]) if params[:status].present?
  end

  def filter_by_floor
    if params[:ground_floor].present?
      params[:ground_floor] == "true" ? @apartments = @apartments.where("floor = 1") : @apartments = @apartments.where("floor > 1")
    end

    return unless params[:last_floor].present? && params[:last_floor] == "true"

    @apartments = @apartments.where("floor = building_floor")
  end

  def filter_by_rooms
    if params[:rooms_min].present? && params[:rooms_max].present? && params[:rooms_max].to_i >= params[:rooms_min].to_i
      @apartments = @apartments.where(rooms: params[:rooms_min].to_i..params[:rooms_max].to_i)
      @houses = @houses.where(rooms: params[:rooms_min].to_i..params[:rooms_max].to_i)
    elsif params[:rooms_min].present?
      @apartments = @apartments.where("rooms >= ? ", params[:rooms_min].to_i)
      @houses = @houses.where("rooms >= ? ", params[:rooms_min].to_i)
    elsif params[:rooms_max].present?
      @apartments = @apartments.where("rooms <= ? ", params[:rooms_max].to_i)
      @houses = @houses.where("rooms <= ? ", params[:rooms_max].to_i)
    end
  end

  def filter_by_surface
    if params[:surface_min].present? && params[:surface_max].present? && params[:surface_max].to_i >= params[:surface_min].to_i
      @apartments = @apartments.where(surface: params[:surface_min].to_i..params[:surface_max].to_i)
      @houses = @houses.where(surface: params[:surface_min].to_i..params[:surface_max].to_i)
    elsif params[:surface_min].present?
      @apartments = @apartments.where("surface >= ? ", params[:surface_min].to_i)
      @houses = @houses.where("surface >= ? ", params[:surface_min].to_i)
    elsif params[:surface_max].present?
      @apartments = @apartments.where("surface <= ? ", params[:surface_max].to_i)
      @houses = @houses.where("surface <= ? ", params[:surface_max].to_i)
    end
  end

  def filter_by_apartment_type
    return unless params[:types].present?

    @apartment_types = params[:types].split(",")
    @houses = @houses.none unless @apartment_types.include?("house")
    @apartments = @apartments.none unless @apartment_types.include?("flat")
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
    @there = "à #{@locations_tags.map(&:name).join(' ou ')}" if @locations_tags.count <= 2
  end

  def filter_the_apartment
    if @cities.present? && @boroughs.present?
      @apartments = @apartments.where(city: @cities).or(@apartments.where(borough: @boroughs))
      @houses = @houses.where(city: @cities).or(@houses.where(borough: @boroughs))
    elsif @cities.present?
      @apartments = @apartments.where(city: @cities)
      @houses = @houses.where(city: @cities)
    elsif @boroughs.present?
      @apartments = @apartments.where(borough: @boroughs)
      @houses = @houses.where(borough: @boroughs)
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
