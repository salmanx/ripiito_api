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
      billing_period
      billing_period_unit
      pricing_type
      pricing_model
      package_type
      exclusive
    ].freeze

    PRICE_ATTRS = %i[
      price
      is_price_visible
      taxable
      tax_fee
      effective_from
      effective_to
    ].freeze
  end
end
