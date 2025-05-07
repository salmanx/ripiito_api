module ErrorHandler
  extend ActiveSupport::Concern

  def render_record_not_found_response(exception)
    model = exception.model&.underscore || 'record'

    render json: ErrorBlueprint.render(
      errors: { model.to_sym => "#{model} doesn't exist" },
      status: 404,
    ), status: :not_found
  end

  def render_error_response(errors)
    render json: ErrorBlueprint.render({ errors: errors, status: 409 }), status: :conflict
  end

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
end
