FactoryGirl.define do
  factory :project do
    organization_id Faker::Number.digit
    description Faker::Hipster.paragraph
    time_frame Faker::Date.forward(30)
    title Faker::HarryPotter.quote
  end
end
