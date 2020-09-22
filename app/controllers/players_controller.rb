class PlayersController < ApplicationController
  def total
    render json: {total: total_players}, status: 200
  end

  private

  def total_players
    Player.total_by_competition(params[:league_code])
  end
end
