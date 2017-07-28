Project.delete_all

10.times do
  Project.create(organization_id: Faker::Number.digit, description: Faker::Hipster.paragraph, time_frame: Faker::Date.forward(30), title: Faker::HarryPotter.quote)
end
