# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  # Handle if Model.find raise RecordNotFound exception
  def render_record_not_found_response(exception)
    model = exception.model&.underscore || 'record'

    render json: ErrorBlueprint.render(
      errors: { model.to_sym => "#{model} doesn't exist" },
      status: 404,
    ), status: :not_found
  end

  # Model validation error
  def render_error_response(errors)
    render json: ErrorBlueprint.render({ errors: errors, status: 409 }), status: :conflict
  end

  # Handle if no params (empty body) passed in post request
  def handle_parameter_missing(exception)
    render json: ErrorBlueprint.render(
      {
        errors: {
          message: exception.message,
        },
        status: 400,
      },
    ), status: :bad_request
  end

  # Handle if no nested attributes passed
  def handle_argument_error(exception)
    render json: ErrorBlueprint.render(
      {
        errors: {
          message: exception.message,
        },
        status: 500,
      },
    ), status: :internal_server_error
  end
end
