FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    author
  end
end
