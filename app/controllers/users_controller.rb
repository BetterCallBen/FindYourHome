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
        lng: property.longitude,
        partial: render_to_string(partial: "marker", locals: { property: property }),
        info_window: render_to_string(partial: "info_window", locals: { favorites: @favorites, property: property })
      }
    end
  end
end
