require 'faker'

FactoryGirl.define do
  factory :organization, class: User do
    org_name { Faker::Company.name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    user_type { 'org' }
    email { Faker::Internet.safe_email }
    password { 'password123' }
    website { Faker::Internet.domain_name }
    description { Faker::StarWars.quote }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
