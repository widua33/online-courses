# frozen_string_literal: true

module Authors
  class Destroy
    include Dry::Monads[:result]

    CANNOT_DESTROY = I18n.t('activerecord.errors.messages.cannot_destroy')
    NO_OTHER_AVAILABLE_AUTHORS = I18n.t('activerecord.errors.messages.no_other_available_authors')

    def initialize(author:)
      @author = author
    end

    def call
      return Failure(author: NO_OTHER_AVAILABLE_AUTHORS) if available_author.nil?

      ActiveRecord::Base.transaction do
        author.courses.update_all(author_id: available_author.id)
        author.destroy
      end

      Success()
    rescue StandardError => e
      Rails.logger.error(e)
      Failure(author: CANNOT_DESTROY)
    end

    private

    attr_reader :author

    def available_author
      @available_author ||= Author.where.not(id: author.id).first
    end
  end
end
