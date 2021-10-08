class NoteSerializer
  include JSONAPI::Serializer
  set_type :assessment_note
  set_id :user_id
  attributes :note, :user_id, :assessment_id, :created_at, :updated_at
end
