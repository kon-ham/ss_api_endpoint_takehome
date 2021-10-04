class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :city
      t.string :state
      t.date :state_date

      t.timestamps
    end
  end
end
