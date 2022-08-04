class FavoriteApartmentsController < ApplicationController
  def create
    @favorite_apartment = FavoriteApartment.new(favorite_apartment_params)
    @favorite_apartment.user = current_user
    if @favorite_apartment.save
      redirect_back(fallback_location: root_path, notice: "Votre appartement a bien été ajouté aux favoris")
    else
      redirect_back(fallback_location: root_path, alert: @favorite_apartment.errors.full_messages.join(', '))
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
