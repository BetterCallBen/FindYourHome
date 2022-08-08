class CitiesController < ApplicationController
  def save_location
    return unless user_signed_in?

    @city = City.find(params[:id])

    if cookies[:locations].present?
      cookies[:locations] = "#{cookies[:locations]},#{@city.insee_code}"
    else
      cookies[:locations] = [@city.insee_code]
    end

    render json: { head: :ok }
  end
end
