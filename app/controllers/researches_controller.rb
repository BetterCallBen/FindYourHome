class ResearchesController < ApplicationController
  def index
    @researches = current_user.researches.includes(research_cities: :city, research_boroughs: :borough)
  end

  def create
    @research = Research.new(research_params)
    @research.user = current_user

    if @research.save
      add_locations_to_research
      link = view_context.link_to '- mes recherches', researches_path
      redirect_back(fallback_location: root_path, notice: "Votre recherche a bien été enregistrée #{link}")
    elsif @research.errors.full_messages.include?("Link has already been taken")
      redirect_back(fallback_location: root_path, alert: "Cette recherche a déjà été enregistrée")
    else
      redirect_back(fallback_location: root_path, alert: @research.errors.full_messages.join(', '))
    end
  end

  private

  def research_params
    params.require(:research).permit(:project, :types, :locations, :rooms, :bedrooms, :surface_min, :surface_max,
                                     :link, :status, :balcony, :chimney, :cellar, :garage, :terrace, :garden, :pool,
                                     :floor)
  end

  def add_locations_to_research
    return unless research_params[:locations]

    Borough.where(insee_code: research_params[:locations].split(',').map(&:to_i)).each do |borough|
      ResearchBorough.create!(research: @research, borough: borough)
    end
    City.where(insee_code: research_params[:locations].split(',').map(&:to_i)).each do |city|
      ResearchCity.create!(research: @research, city: city)
    end
  end
end
