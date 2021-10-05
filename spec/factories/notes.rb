FactoryBot.define do
  factory :note do
    note { Faker::Lorem.paragraph }
  end
end
