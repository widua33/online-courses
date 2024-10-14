# frozen_string_literal: true

module ErrorsHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
  end

  private

  def not_found
    head :not_found
  end

  def parameter_missing(error)
    render json: { error: I18n.t('errors.parameter_missing', param: error.param) }, status: :bad_request
  end
end
