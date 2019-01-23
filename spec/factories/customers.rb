FactoryBot.define do
  factory :customer, class: Customer do
    sequence(:first_name) { |n| "First_Name_#{n}" }
    sequence(:last_name) { |n| "Last_Name_#{n}" }
  end
end
