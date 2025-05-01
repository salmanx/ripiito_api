# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_error_response(errors, status)
    render json: ErrorBlueprint.render({ errors: errors, status: status }), status: status
  end
end
