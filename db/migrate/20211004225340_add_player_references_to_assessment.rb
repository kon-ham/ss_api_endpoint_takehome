class AddPlayerReferencesToAssessment < ActiveRecord::Migration[5.2]
  def change
    add_reference :assessments, :player, foreign_key: true
  end
end
