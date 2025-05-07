# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandler
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
end
