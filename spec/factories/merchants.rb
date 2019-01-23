FactoryBot.define do
  factory :merchant, class: Merchant do
    sequence(:name) { |n| "Name_#{n}" }
  end
end
