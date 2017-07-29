FactoryGirl.define do
  factory :proposal do
    project_id { Project.all.sample.id }
    user_id { User.where(user_type: 'dev').sample.id }
    description Faker::Hipster.paragraph
    selected false
  end
end
