# frozen_string_literal: true

class PackageBlueprint < Blueprint
  exclude :id

  field :slug

  fields(*Attributes::PackageAttributes::PACKAGE_ATTRS)
end
