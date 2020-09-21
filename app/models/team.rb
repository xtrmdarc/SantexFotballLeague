class Team < ApplicationRecord
  has_many :competition_teams, foreign_key: :team_id
  has_many :competitions, through: :competition_teams
  has_many :players
end
