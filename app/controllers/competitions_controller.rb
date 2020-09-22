class CompetitionsController < ApplicationController
  def import
    p StoreLeagueDataService.save params[:league_code]

    render json: {message: 'imported successfully'}, code: 202
  end
end
