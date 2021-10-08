class PlayerSerializer
  include JSONAPI::Serializer
  set_type :players
  attributes :first_name, :last_name, :height, :weight, :birthday, :graduation_year, :position, :recruit
end
