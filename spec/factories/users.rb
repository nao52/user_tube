FactoryBot.define do
  factory :user do
    password = "password"
    
    name { "みずき" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { password }
    password_confirmation { password }
    age { 20 }
    gender { 1 }
  end
end
