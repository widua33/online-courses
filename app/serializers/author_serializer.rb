# frozen_string_literal: true

class AuthorSerializer < Oj::Serializer
  attributes :id, :first_name, :last_name
end
