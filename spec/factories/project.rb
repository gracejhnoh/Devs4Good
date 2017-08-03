FactoryGirl.define do
  factory :project do
    organization_id { User.where(user_type: 'org').sample.id }
    summary Faker::Lorem.sentence(1)
    description Faker::Hipster.paragraph
    time_frame Faker::Date.forward(30)
    title Faker::Lorem.characters(20)
    contact_email Faker::Internet.safe_email
  end
end
