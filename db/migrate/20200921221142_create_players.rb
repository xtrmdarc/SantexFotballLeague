class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.date :dateOfBirth
      t.string :countryOfBirth
      t.string :nationality
      t.integer :team_id

      t.timestamps
    end
  end
end
