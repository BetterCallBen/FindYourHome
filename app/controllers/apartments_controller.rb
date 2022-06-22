class ApartmentsController < ApplicationController
  def index
    if params[:paris].present? && params[:lyon].present?
      @apartments = Apartment.where("address ILIKE '%Paris%'").or(Apartment.where("address ILIKE '%Lyon%'"))
    elsif params[:paris].present?
      @apartments = Apartment.where("address ILIKE '%Paris%'")
    elsif params[:lyon].present?
      @apartments = Apartment.where("address ILIKE '%Lyon%'")
    else
      @apartments = Apartment.all
    end

    @apartments = @apartments.where("name ILIKE ? ", "%#{params[:search]}%") if params[:search].present?

    @apartments = @apartments.where("status ILIKE ? ", params[:status]) if params[:status].present?

    if params[:rooms_min].present? && params[:rooms_max].present? && params[:rooms_max].to_i >= params[:rooms_min].to_i
      @apartments = @apartments.where(rooms: params[:rooms_min].to_i..params[:rooms_max].to_i)
    elsif params[:rooms_min].present?
      @apartments = @apartments.where("rooms >= ? ", params[:rooms_min].to_i)
    elsif params[:rooms_max].present?
      @apartments = @apartments.where("rooms <= ? ", params[:rooms_max].to_i)
    end

    if params[:surface_min].present? && params[:surface_max].present? && params[:surface_max].to_i >= params[:surface_min].to_i
      @apartments = @apartments.where(surface: params[:surface_min].to_i..params[:surface_max].to_i)
    elsif params[:surface_min].present?
      @apartments = @apartments.where("surface >= ? ", params[:surface_min].to_i)
    elsif params[:surface_max].present?
      @apartments = @apartments.where("surface <= ? ", params[:surface_max].to_i)
    end

    if params[:reviews].present?
      @reviews = JSON.parse params[:reviews].map(&:id)
    else
      @reviews = Review.first(2).map(&:id)
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'apartments', locals: { apartments: @apartments }, formats: :html }
    end
  end

  def show
    @apartment = Apartment.find(params[:id])
    @review = Review.new
  end
end
