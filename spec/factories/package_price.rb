# frozen_string_literal: true

FactoryBot.define do
  factory :package_price do
    price { 100.00 }

    association :package
  end
end
