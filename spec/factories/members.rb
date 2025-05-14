# frozen_string_literal: true

FactoryBot.define do
  factory :member do
    fullname { Faker::Name.name[0..10] }
    username { Faker::Name.unique.name[0..5] }
    email { Faker::Internet.email[0..20] }
    password { 'secret' }

    association :tenant
  end
end
