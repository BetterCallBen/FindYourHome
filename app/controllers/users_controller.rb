class UsersController < ApplicationController
  def favorites
    @favorites = current_user.apartments + current_user.houses
  end
end
