# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :todo do
    user
    text { user.nil? ? "Pick up the milk." : "Pick up #{user.email}'s milk."  }
  end
end
