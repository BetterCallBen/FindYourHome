class ResearchesController < ApplicationController
  def index
    @researches = current_user.researches.includes(research_cities: :city, research_boroughs: :borough)
  end

  def create
    @research = Research.new(research_params)
    @research.user = current_user
    Borough.where(insee_code: research_params[:locations].split(',').map(&:to_i)).each do |borough|
      ResearchBorough.create!(research: @research, borough: borough)
    end
    City.where(insee_code: research_params[:locations].split(',').map(&:to_i)).each do |city|
      ResearchCity.create!(research: @research, city: city)
    end

    if @research.save
      redirect_back(fallback_location: root_path, notice: "Votre recherche a bien été enregistrée")
    else
      redirect_back(fallback_location: root_path, alert: "Une erreur est survenue")
    end
  end

  def research_params
    params.require(:research).permit(:project, :types, :locations, :rooms, :bedrooms, :surface_min, :surface_max,
                                     :link, :status, :balcony, :chimney, :cellar, :garage, :terrace, :garden, :pool,
                                     :floor)
  end
end
