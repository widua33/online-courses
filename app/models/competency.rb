# frozen_string_literal: true

class Competency < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
end
