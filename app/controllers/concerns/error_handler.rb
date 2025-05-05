module ErrorHandler
  extend ActiveSupport::Concern

  def render_record_not_found_response(exception)
    model = exception.model&.underscore || 'record'

    render json: ErrorBlueprint.render(
      status: 404,
      errors: { model.to_sym => 'not found' },
    ), status: :not_found
  end

  def render_error_response(errors, status)
    render json: ErrorBlueprint.render({ errors: errors, status: status }), status: status
  end
end
