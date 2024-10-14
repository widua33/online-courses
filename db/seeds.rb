# frozen_string_literal: true

3.times do
  author = FactoryBot.create(:author)
  course = FactoryBot.create(:course, author: author)
  FactoryBot.create_list(:competency, 3, course: course)
end
