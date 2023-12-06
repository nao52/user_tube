FactoryBot.define do
  factory :user do
    password = "password"
    
    name { Faker::Name.name }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { password }
    password_confirmation { password }
    age { 20 }
    gender { 1 }
    profile { "私はテスト用のユーザーです。よろしくお願いします。" }
  end
end
