class CreateCompetitionTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :competition_teams do |t|
      t.integer :competition_id
      t.integer :team_id

      t.timestamps
    end
  end
end
