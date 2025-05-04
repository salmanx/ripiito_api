# frozen_string_literal: true

module Enum
  module PlanEnum
    STATUSES = {
      DRAFT: 'DRAFT',
      ACTIVE: 'ACTIVE',
      RETIRED: 'RETIRED',
    }.freeze

    BILLING_PERIOD_UNITS = {
      DAY: 'DAY',
      WEEK: 'WEEK',
      MONTH: 'MONTH',
      YEAR: 'YEAR',
    }.freeze

    CURRENCY_CODE = {
      JPY: 'JPY',
      USD: 'USD',
      EUR: 'EUR',
    }.freeze
  end
end
