class AssessmentSerializer
  include JSONAPI::Serializer
  set_type :assessment
  set_id :user_id
  attributes :rating, :user_id, :player_id, :tournament_id, :assessment_type, :created_at, :updated_at
  has_many :notes, key: :assessment_notes
end
