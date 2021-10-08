class TeamSerializer
  include JSONAPI::Serializer
  set_type :teams
  attributes :name, :age_group, :coach
end
