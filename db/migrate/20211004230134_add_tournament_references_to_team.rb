class AddTournamentReferencesToTeam < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :tournament, foreign_key: true
  end
end
