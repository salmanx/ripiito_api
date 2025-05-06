# frozen_string_literal: true

FactoryBot.define do
  factory :package do
    name { Faker::Company.name[0...10] }
    billing_period { 1 }
    billing_period_unit { 'MONTH' }
    auto_renewable { false }
    cancelable { true }
    base_price { 100.00 }
    status { 'DRAFT' }
    package_type { 'REQUIRED' }
    pricing_model { 'FIXED' }
    pricing_type { 'RECURRING' }

    association :plan
  end
end
