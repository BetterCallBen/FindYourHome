class ApartmentsController < ApplicationController
  def show
    @apartment = Apartment.find(params[:id])
  end
end
