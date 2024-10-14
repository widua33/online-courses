# frozen_string_literal: true

class CompetencySerializer < Oj::Serializer
  attributes :id, :name

  has_one :course, serializer: CourseSerializer
end
