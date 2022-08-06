class ApartmentsController < ApplicationController
  def show
    @apartment = Apartment.find(params[:id])
  end

  def remove_favorite
    @apartment = Apartment.find(params[:id])
    @apartment.favorite_apartments.find_by(user: current_user).destroy
    render json: { head: :ok }
  end

  def add_favorite
    @favorite_apartment = FavoriteApartment.new
    @favorite_apartment.apartment = Apartment.find(params[:id])
    @favorite_apartment.user = current_user
    @favorite_apartment.save
    render json: { head: :ok }
  end
end
