class NoteSerializer
  include JSONAPI::Serializer
  set_type :assessment_note
  set_id :user_id
  attributes :note

  belongs_to :assessment
  belongs_to :user
end
