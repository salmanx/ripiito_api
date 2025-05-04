# frozen_string_literal: true

module Enum
  module PlanEnum
    STATUSES = %w[DRAFT ACTIVE RETIRED].freeze
    BILLING_PERIOD_UNITS = %w[DAY WEEK MONTH YEAR].freeze
    CURRENCY_CODE = %w[JPY USD EUR].freeze
  end
end
