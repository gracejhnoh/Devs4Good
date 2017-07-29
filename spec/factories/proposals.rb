FactoryGirl.define do
  factory :proposal do
    project Faker::Number.digit
    developer Faker::Number.digit
    description Faker::Hipster.paragraph
    selected false
  end
end
