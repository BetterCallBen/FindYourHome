class BoroughsController < ApplicationController
  def add_recent_location
    return unless user_signed_in?

    @borough = Borough.find(params[:id])

    if cookies[:locations].present?
      cookies[:locations] = { value: "#{cookies[:locations]},#{@borough.insee_code}", expires: 1.week.from_now }
    else
      cookies[:locations] = { value: [@borough.insee_code], expires: 1.week.from_now }
    end

    render json: { head: :ok }
  end
end
