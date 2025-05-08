# frozen_string_literal: true

class PackagePriceBlueprint < Blueprint
  exclude :id

  fields(*Attributes::PackageAttributes::PRICE_ATTRS)
end
