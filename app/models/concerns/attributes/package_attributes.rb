# frozen_string_literal: true

module Attributes
  module PackageAttributes
    PACKAGE_ATTRS = %i[
      name
      status
      auto_renewable
      cancelable
      trial_days
      max_subscriber
      base_price
      tax_fee
      taxable
      is_price_visible
      billing_period
      billing_period_unit
      pricing_type
      pricing_model
      package_type
      exclusive
    ].freeze
  end
end
