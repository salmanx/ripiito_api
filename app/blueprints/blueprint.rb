# frozen_string_literal: true

class Blueprint < Blueprinter::Base
  identifier :id

  fields(
    :created_at,
    :updated_at,
  )
end
