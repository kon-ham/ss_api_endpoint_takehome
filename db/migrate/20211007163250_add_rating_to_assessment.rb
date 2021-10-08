class AddRatingToAssessment < ActiveRecord::Migration[5.2]
  def change
    add_column :assessments, :rating, :integer
  end
end
