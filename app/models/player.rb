class Player < ApplicationRecord
  belongs_to :team

  def self.total_by_competition(league_code)
    joins(team: :competitions).where(competitions: {code: league_code}).count
  end
end
