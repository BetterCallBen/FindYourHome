class ResearchesController < ApplicationController
  def index
    @researches = current_user.researches
  end

  def create
    @research = Research.new(research_params)
    @research.user = current_user
    puts "research saved"
    puts @research.inspect
    puts "research saved"
    if @research.save
      redirect_back(fallback_location: root_path, notice: "Votre recherche a bien été enregistrée")
    else
      redirect_back(fallback_location: root_path, alert: "Une erreur est survenue")
    end
  end

  def research_params
    params.require(:research).permit(:project, :types, :locations, :rooms, :bedrooms, :surface_min, :surface_max, :link, :status, :balcony, :chimney, :cellar, :garage, :terrace, :garden, :pool, :ground_floor)
  end
end
