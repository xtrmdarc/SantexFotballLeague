class Competition < ApplicationRecord
  has_many :competition_teams, foreign_key: :competition_id
  has_many :teams, through: :competition_teams
end
