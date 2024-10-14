# frozen_string_literal: true

3.times do
  author = FactoryBot.create(:author)
  FactoryBot.create(:course, author: author)
end
