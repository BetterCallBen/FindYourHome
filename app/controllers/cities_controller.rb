class CitiesController < ApplicationController
  def add_recent_location
    return unless user_signed_in?

    @city = City.find(params[:id])

    if cookies[:locations].present?
      cookies[:locations] = { value: "#{cookies[:locations]},#{@city.insee_code}", expires: 1.day.from_now }
    else
      cookies[:locations] = { value: [@city.insee_code], expires: 1.day.from_now }
    end

    render json: { head: :ok }
  end
end
