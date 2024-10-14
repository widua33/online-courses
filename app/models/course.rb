# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :author
  has_many :competencies, dependent: :destroy

  validates :name, presence: true
end
