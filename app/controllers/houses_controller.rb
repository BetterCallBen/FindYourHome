class HousesController < ApplicationController
  def show
    @house = House.find(params[:id])

  end
  def add_favorite
    @favorite_house = FavoriteHouse.new
    @favorite_house.house = House.find(params[:id])
    if user_signed_in?
      @favorite_house.user = current_user
    else
      redirect_to new_user_session_path
    end

    if @favorite_house.save
      render json: { head: :ok, message: "La maison a bien été ajouté à vos favoris" }
    end
  end

  def remove_favorite
    @house = House.find(params[:id])
    @house.favorite_houses.find_by(user: current_user).destroy
    render json: { head: :ok, message: "La maison a bien été enlevée de vos favoris" }
  end
end
