class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :tla
      t.string :shortName
      t.string :areaName
      t.string :email

      t.timestamps
    end
  end
end
