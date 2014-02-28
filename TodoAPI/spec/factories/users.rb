# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "name#{n}@example.com" }
    password "pass1234"

    factory :user_with_short_password do
      password "abc"
    end
  end
end
