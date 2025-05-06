# frozen_string_literal: true

module Enum
  module PlanEnum
    STATUSES = {
      DRAFT: 'DRAFT',
      ACTIVE: 'ACTIVE',
      RETIRED: 'RETIRED',
    }.freeze

    CURRENCY_CODE = {
      JPY: 'JPY',
      USD: 'USD',
      EUR: 'EUR',
    }.freeze
  end
end
