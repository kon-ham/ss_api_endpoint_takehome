FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
    age_group { "N/A" }
    coach { Faker::Name.name  }
  end
end
