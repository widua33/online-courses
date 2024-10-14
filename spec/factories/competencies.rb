FactoryBot.define do
  factory :competency do
    name { Faker::Educator.subject }
    course
  end
end
