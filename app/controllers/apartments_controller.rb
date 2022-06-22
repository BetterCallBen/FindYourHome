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

    @reviews_ids = params[:reviews].split(",").map(&:to_i) if params[:reviews].present?
    @reviews = Review.where(id: @reviews_ids) if @reviews_ids.present?

    @result = Review.where("content ILIKE ? ", "%#{params[:search]}%") if params[:search].present?

    respond_to do |format|
      format.html
      format.text { render partial: 'reviews', locals: { reviews: @result }, formats: :html }
    end
  end

  def show
    @apartment = Apartment.find(params[:id])
    @review = Review.new
  end
end
