class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :age_group
      t.string :coach

      t.timestamps
    end
  end
end
