class ChangeColumnNameForTournament < ActiveRecord::Migration[5.2]
  def change
    rename_column :tournaments, :state_date, :start_date
  end
end
