# frozen_string_literal: true

class ErrorBlueprint < Blueprinter::Base
  field :status

  field :errors do |error_object|
    raw_errors = error_object[:errors]

    if raw_errors.respond_to?(:messages)
      raw_errors.messages.each_with_object({}) do |(key, messages), result|
        result[key] = messages.map { |msg| "#{Utils::TextFormatter.clean_humanized_title(key)} #{msg}" }
      end

    else
      raw_errors.transform_values { |messages| [messages].flatten.first(1) }
    end
  end
end
