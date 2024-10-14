# frozen_string_literal: true

class CourseSerializer < Oj::Serializer
  attributes :id, :name

  has_one :author, serializer: AuthorSerializer
end
