FactoryBot.define do
  factory :player do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name  }
    height { Faker::Number.between(from: 36, to: 96) }
    weight { Faker::Number.between(from: 1, to: 400) }
    birthday { Faker::Date.between(from: '1900-01-01', to: Date.today) }
    graduation_year { Faker::Number.between(from: 1900, to: 2050) }
    position { Faker::Sports::Football.position }
    recruit { Faker::Boolean.boolean }
  end
end
