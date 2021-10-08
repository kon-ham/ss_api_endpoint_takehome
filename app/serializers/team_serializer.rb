class TeamSerializer
  include JSONAPI::Serializer
  set_type :teams
  attributes :name, :age_group
  has_many :players
end
