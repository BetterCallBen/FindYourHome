class ResearchesController < ApplicationController
  def create
    @research = Research.new(research_params)
    @research.user = current_user
    if @research.save
      redirect_back(fallback_location: root_path, notice: "Votre recherche a bien été enregistrée")
    else
      redirect_back(fallback_location: root_path, alert: "Une erreur est survenue")
    end
  end

  def research_params
    params.require(:research).permit(:city, :borough, :rooms, :bedrooms, :type, :project, :link)
  end
end
