class FavoriteApartmentsController < ApplicationController
  def create
    @favorite_apartment = FavoriteApartment.new(favorite_apartment_params)
    @favorite_apartment.user = current_user
    if @favorite_apartment.save
      render json: { success: true }
    else
      render json: { success: false, errors: restaurant.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite_apartment = FavoriteApartment.find(params[:id])
    @favorite_apartment.destroy
    render json: { success: true }
  end

  private

  def favorite_apartment_params
    params.require(:favorite_apartment).permit(:apartment_id)
  end
end
