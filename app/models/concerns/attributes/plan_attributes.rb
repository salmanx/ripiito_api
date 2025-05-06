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
      exclusive
    ].freeze
  end
end
