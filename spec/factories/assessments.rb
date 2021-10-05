FactoryBot.define do
  factory :assessment do
    assessment_type { Faker::Lorem.word }
  end
end
