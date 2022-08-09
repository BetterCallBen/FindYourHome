class BoroughsController < ApplicationController
  def add_recent_location
    return unless user_signed_in?

    @borough = Borough.find(params[:id])

    if cookies[:locations].present?
      cookies[:locations] = "#{cookies[:locations]},#{@borough.insee_code}"
    else
      cookies[:locations] = [@borough.insee_code]
    end

    render json: { head: :ok }
  end
end
