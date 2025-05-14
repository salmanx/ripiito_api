# frozen_string_literal: true

class PackageBlueprint < Blueprint
  field :slug

  fields(*Attributes::PackageAttributes::PACKAGE_ATTRS)

  association :package_price, blueprint: PackagePriceBlueprint
end
