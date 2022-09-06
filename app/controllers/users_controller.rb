class UsersController < ApplicationController
  def favorites
    @apartments = current_user.apartments
    @houses = current_user.houses

    @favorites = @apartments + @houses

    @apartments_markers = add_markers(@apartments)
    @houses_markers = add_markers(@houses)

    @markers = @apartments_markers + @houses_markers
  end

  private

  def add_markers(properties)
    properties.geocoded.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude
      }
    end
  end
end
