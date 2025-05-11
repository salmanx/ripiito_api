# frozen_string_literal: true

FactoryBot.define do
  factory :member_package do
    member { nil }
    package { nil }
    payment_method { 'MyString' }
    purchase_price { 'MyString' }
    tax { 'MyString' }
    total_price { 'MyString' }
    status { 'MyString' }
  end
end
