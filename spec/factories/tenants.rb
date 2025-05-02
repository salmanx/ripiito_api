FactoryBot.define do
  factory :tenant do
    name { Faker::Company.name }
    ip { Faker::Internet.ip_v4_address }
    location { Faker::Address.full_address }
    url { 'https://test.com' }
  end
end
