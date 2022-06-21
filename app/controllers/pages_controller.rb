class PagesController < ApplicationController
  def home
    redirect_to apartments_path
  end
end
