# frozen_string_literal: true

require 'subroutine/association_fields'

class Op < Subroutine::Op
  include ::Subroutine::AssociationFields

  def success?
    errors.empty?
  end

  def failure?
    errors.any?
  end

  def extract_attributes(keys)
    # public_send dynamically collects values for given keys from the object, using public getter methods,
    # and builds a hash
    # perfect for mass-assigning models where key value are same like Model.new(attrs).
    keys.index_with { |key| public_send(key) }
  end
end
