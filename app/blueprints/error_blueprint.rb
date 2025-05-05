# frozen_string_literal: true

class ErrorBlueprint < Blueprinter::Base
  field :status

  field :errors do |error_object|
    # make sure always return first error from the errors array for particular error
    raw_errors = error_object[:errors]

    if raw_errors.respond_to?(:messages)
      # ActiveModel::Errors (from Subroutine)
      raw_errors.messages.transform_values { |messages| [messages.first] }
    else
      # Plain hash
      raw_errors.transform_values { |messages| [messages].flatten.first(1) }
    end
  end
end
