FactoryBot.define do
  factory :tournament do
    name { Faker::WorldCup.stadium }
    city { Faker::Nation.capital_city }
    state { Faker::Name.initials(number: 2) }
    start_date { Faker::Date.between(from: Date.today, to: '2050-01-01') }
  end
end
