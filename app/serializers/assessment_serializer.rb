class AssessmentSerializer
  include JSONAPI::Serializer

  set_type :assessment
  set_id :user_id
  attributes :rating
  has_many :notes
  belongs_to :user
  belongs_to :player
  belongs_to :tournament
end
