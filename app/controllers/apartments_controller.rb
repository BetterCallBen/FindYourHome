class ApartmentsController < ApplicationController
  def index
    @apartments = Apartment.all

    filter_by_criterias
    ## rooms
    filter_by_rooms
    ## surface
    filter_by_surface
    ## location
    filter_by_locations

    respond_to do |format|
      format.html
      format.text { render partial: 'locations', locals: { locations: @result }, formats: :html }
    end
  end

  def show
    @apartment = Apartment.find(params[:id])
    @review = Review.new
  end

  private

  def filter_by_criterias
    ## balcon
    @apartments = @apartments.where(balcony: true) if params[:balcony].present?
    ## cheminée
    @apartments = @apartments.where(chimney: true) if params[:chimney].present?
    ## ascenseur
    @apartments = @apartments.where(elevator: true) if params[:elevator].present?
    ## meublé / non meublé
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
    @locations_ids = params[:locations].split(",").map(&:to_i) if params[:locations].present?
    @locations_tags = Location.where(id: @locations_ids) if @locations_ids.present?

    @apartments = @apartments.where(location: @locations_tags) if @locations_tags.present?

    @result = Location.where("name ILIKE ? ", "%#{params[:search]}%") if params[:search].present?
    @result = @result.where.not(id: @locations_ids) if @locations_ids.present? && @result.present?
  end

  def order_by_type(locations)
    return if locations.nil?

    locations.order(location_type: :desc)
  end
end
