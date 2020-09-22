class CompetitionsController < ApplicationController
  def import
    process = StoreLeagueDataService.save params[:league_code]

    render json: process[:response], code: process[:status]
  end
end
