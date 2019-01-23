FactoryBot.define do
  factory :item do
    association :merchant, factory: :merchant
    sequence(:name) { |n| "Item_Name_#{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:unit_price) { |n| n.to_i }
  end
end
