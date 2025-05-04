# frozen_string_literal: true

module Attributes
  module PlanAttributes
    PLAN_ATTRS = %i[
      name
      status
      billing_period
      billing_period_unit
      duration
      auto_renewable
      cancelable
      base_price
      trial_days
      is_price_visible
      currency
      max_subscriber
      taxable
      tax_fee
    ].freeze
  end
end
