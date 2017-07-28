FactoryGirl.define do
  factory :proposal do
    project nil
    developer nil
    description "MyText"
    selected? false
  end
end
