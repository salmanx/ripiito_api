# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandler
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  rescue_from ArgumentError, with: :handle_argument_error
  rescue_from ActiveRecord::RecordNotUnique, with: :handle_duplicate_key_constraint
end
