# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    name { Faker::Company.name[0...10] }
    duration { 90 }
    auto_renewable { false }
    cancelable { true }
    currency { 'JPY' }
    status { 'DRAFT' }

    association :tenant
  end
end
