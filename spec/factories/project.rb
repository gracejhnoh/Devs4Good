FactoryGirl.define do
  factory :project do
    organization_id { User.where(user_type: 'org').sample.id }
    summary Faker::Lorem.sentence(1)
    description Faker::Hipster.paragraph
    time_frame Faker::Date.forward(30)
    title Faker::HarryPotter.quote
  end
end
