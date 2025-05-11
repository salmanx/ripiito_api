FactoryBot.define do
  factory :member do
    fullname { "MyString" }
    username { "MyString" }
    email { "MyString" }
    password { "MyString" }
    tenant { nil }
  end
end
