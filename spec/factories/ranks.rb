FactoryBot.define do
  factory :ranks do
    score_from { Faker::Number.decimal(2) }
    score_to { Faker::Number.decimal(2) }
    name 'test rank'
  end
end
