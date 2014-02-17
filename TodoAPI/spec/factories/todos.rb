# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :todo do
    text "MyText"
    due_date "2014-02-17"
    priority 1
    completed false
  end
end
