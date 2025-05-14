# frozen_string_literal: true

FactoryBot.define do
  factory :member_package do
    payment_method { 'CARD' }
    purchase_price { 100.00 }
    tax_fee { 0.0 }
    total_price { 100.00 }
    active { true }

    association :package
    association :member
  end
end
