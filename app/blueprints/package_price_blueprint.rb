# frozen_string_literal: true

class PackagePriceBlueprint < Blueprint
  fields(*Attributes::PackageAttributes::PRICE_ATTRS)
end
