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
        lat: property.latitude || 45.7620426,
        lng: property.longitude || 4.8274527,
        partial: render_to_string(partial: "marker", locals: { property: property }),
        price: property.price,
        info_window: render_to_string(partial: "info_window", locals: { favorites: @favorites, property: property })
      }
    end
  end
end
