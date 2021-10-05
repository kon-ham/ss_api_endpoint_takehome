class AddAssessmentTypeToAssessments < ActiveRecord::Migration[5.2]
  def change
    add_column :assessments, :assessment_type, :string, :default => "event"
  end
end
