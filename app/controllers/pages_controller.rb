class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  PER_PAGE = 20

  def home
    redirect_to properties_path
  end

  def index
    init_properties
    filter_properties
    sort_properties
    paginate_properties

    init_favorites

    define_what_to_display

    respond_to do |format|
      format.html
      format.text { render partial: 'locations', formats: :html }
      format.json { render json: @properties.count }
    end
  end

  private

  def init_properties
    @apartments = Apartment.includes(:city, :borough)
    @houses = House.includes(:city, :borough)
  end

  def filter_properties
    filter_by_criterias
    filter_by_status
    filter_by_floor
    filter_by_rooms
    filter_by_bedrooms
    filter_by_surface
    filter_by_locations
    filter_by_type
    filter_by_project
    @properties = (@apartments + @houses).uniq
  end

  def sort_properties
    case params[:sort]
    when "price"
      @properties = @properties.sort_by(&:price)
    when "surface"
      @properties = @properties.sort_by(&:surface)
    else
      @properties = BestPropertiesService.new(@properties).call
    end
  end

  def paginate_properties
    @current_page = params[:page].present? && params[:page].to_i.positive? ? params[:page].to_i : 1
    @pagination_max = (@properties.count.to_f / PER_PAGE).ceil

    if params[:page].present?
      @first_part = ((@current_page - 1) * PER_PAGE)
      @last_part = (@current_page * PER_PAGE) - 1
    else
      @first_part = 1
      @last_part = PER_PAGE
    end

    @properties_paginated = @properties[@first_part..@last_part]
  end

  def init_favorites
    return unless user_signed_in?

    @favorite_apartments = current_user.apartments
    @favorite_houses = current_user.houses
  end

  def filter_by_project
    return unless params[:project].present?

    @apartments = @apartments.where(project: params[:project])
    @houses = @houses.where(project: params[:project])
  end

  def filter_by_criterias
    filter_for_houses
    filter_for_apartments
  end

  def filter_for_houses
    %i[balcony chimney cellar garage terrace garden pool].each do |criteria|
      next unless params[criteria].present?

      @houses = @houses.where(criteria => true)
    end
  end

  def filter_for_apartments
    %i[balcony chimney cellar garage terrace elevator].each do |criteria|
      next unless params[criteria].present?

      @apartments = @apartments.where(criteria => true)
    end
  end

  def filter_by_status
    ## meublé / non meublé
    return unless params[:status].present?

    @apartments = @apartments.where("status ILIKE ? ", params[:status])
    @houses = @houses.where("status ILIKE ? ", params[:status])
  end

  def filter_by_floor
    return unless params[:floor].present?

    @apartments = @apartments.where("floor = 1") if params[:floor] == "ground"
    @apartments = @apartments.where("floor > 1") if params[:floor] == "not ground"
    @apartments = @apartments.where("floor = building_floor") if params[:floor] == "last"
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

  def filter_by_type
    return unless params[:types].present?

    @houses = @houses.none unless params[:types].include?("house")
    @apartments = @apartments.none unless params[:types].include?("flat")
  end

  def filter_by_locations
    @locations_insees = params[:locations].split(",") if params[:locations].present?

    find_location_tags if @locations_insees.present?

    filter_the_apartment

    ## les resultats affichés
    return unless params[:search].present?

    find_results
  end

  def filter_by_rooms
    return unless params[:rooms].present?

    @rooms = params[:rooms].chars
    if @rooms.include?("5")
      @apartments = @apartments.where("rooms > 5").or(@apartments.where(rooms: @rooms))
      @houses = @houses.where("rooms > 5").or(@houses.where(rooms: @rooms))
    else
      @apartments = @apartments.where(rooms: @rooms)
      @houses = @houses.where(rooms: @rooms)
    end
  end

  def filter_by_bedrooms
    return unless params[:bedrooms].present?

    @bedrooms = params[:bedrooms].chars
    if @bedrooms.include?("5")
      @apartments = @apartments.where("bedrooms > 5").or(@apartments.where(bedrooms: @bedrooms))
      @houses = @houses.where("bedrooms > 5").or(@houses.where(bedrooms: @bedrooms))
    else
      @apartments = @apartments.where(bedrooms: @bedrooms)
      @houses = @houses.where(bedrooms: @bedrooms)
    end
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
    @city_search_query = "name ILIKE ? ", "%#{params[:search].gsub(' ', '-').gsub('st', 'Saint')}%"
    @borough_search_query = "name ILIKE ? ", "%#{params[:search]}%"

    find_matching_locations
    find_recent_locations

    @recent_locations = [] unless @recent_locations.present?

    @results = @matching_locations - @recent_locations

    @number_of_results = @recent_locations.count <= 3 ? 6 - @recent_locations.count : 3
  end

  def find_matching_locations
    ## cherche les villes
    @matching_cities = City.where(@city_search_query).where.not(insee_code: @locations_insees)
    ## cherche les quartiers
    @matching_borough = Borough.where(@borough_search_query).where.not(insee_code: @locations_insees)

    @matching_locations = @matching_cities + @matching_borough
  end

  def find_recent_locations
    return unless cookies[:locations].present?

    @cookies_locations = cookies[:locations].split(",")

    ## cherche les villes recherchées récemment
    @recent_cities = City.where(insee_code: @cookies_locations)
    @recent_cities = @recent_cities.where(@city_search_query).where.not(insee_code: @locations_insees)

    ## cherche les quartiers recherchés récemment
    @recent_boroughs = Borough.where(insee_code: @cookies_locations)
    @recent_boroughs = @recent_boroughs.where(@borough_search_query).where.not(insee_code: @locations_insees)

    @recent_locations = @recent_cities + @recent_boroughs
  end

  def define_what_to_display
    if @properties.count == @properties.select { |p| p.instance_of?(Apartment) }.count
      @what = "appartement"
    elsif @properties.count == @properties.select { |p| p.instance_of?(House) }.count
      @what = "maison"
    else
      @what = "bien"
    end
  end
end
