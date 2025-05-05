# frozen_string_literal: true

module Attributes
  module PlanAttributes
    PLAN_ATTRS = %i[
      name
      status
      duration
      auto_renewable
      cancelable
      trial_days
      currency
      max_subscriber
    ].freeze
  end
end
# base_price
# tax_fee
# taxable
# is_price_visible
# billing_period
# billing_period_unit
