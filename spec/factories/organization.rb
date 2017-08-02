require 'faker'

FactoryGirl.define do
  factory :organization, class: User do
    org_name { Faker::Company.name }
    ein { Faker::Number.number(9) }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { '98101' }
    user_type { 'org' }
    email { Faker::Internet.safe_email }
    password { 'password123' }
    website { Faker::Internet.url }
    description { Faker::StarWars.quote }
    phone { '356-456-5555' }
  end
end
