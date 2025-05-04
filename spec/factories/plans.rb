# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    name { Faker::Company.name[0...10] }
    billing_period { 1 }
    duration { 90 }
    auto_renewable { false }
    cancelable { true }
    base_price { 100.00 }
    trial_days { 3 }
    is_price_visible { true }
    currency { 'JPY' }
    taxable { false }
    billing_period_unit { 'MONTH' }
    status { 'DRAFT' }
  end
end
