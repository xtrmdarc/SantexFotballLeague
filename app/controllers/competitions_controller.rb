class CompetitionsController < ApplicationController
  def import
    process = StoreLeagueDataService.save params[:league_code]
    puts process[:statu]
    render json: process[:response], status: process[:status]
  end
end
