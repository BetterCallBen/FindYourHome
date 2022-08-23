class ApartmentsController < ApplicationController
  def show
    @apartment = Apartment.find(params[:id])
  end

  def remove_favorite
    @apartment = Apartment.find(params[:id])
    @apartment.favorite_apartments.find_by(user: current_user).destroy
    render json: { head: :ok, message: "L'appartement a bien été enlevé de vos favoris" }
  end

  def add_favorite
    @favorite_apartment = FavoriteApartment.new
    @favorite_apartment.apartment = Apartment.find(params[:id])
    @favorite_apartment.user = current_user
    @favorite_apartment.save
    render json: { head: :ok, message: "L'appartement a bien été ajouté à vos favoris" }
  end
end
