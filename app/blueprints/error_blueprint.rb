# frozen_string_literal: true

class ErrorBlueprint < Blueprint
  field :status

  field :errors do |error_object|
    # make sure always return first error from the errors array for particular error
    error_object[:errors].messages.transform_values { |messages| [messages.first] }
  end
end
