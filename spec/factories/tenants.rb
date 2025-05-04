# frozen_string_literal: true

FactoryBot.define do
  factory :tenant do
    name { Faker::Company.name[0...10] }
    location { Faker::Address.full_address[0..15] }
    url { Faker::Internet.url(host: 'test') }
  end
end
