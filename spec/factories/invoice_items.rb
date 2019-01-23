FactoryBot.define do
  factory :invoice_item do
    associaton :item, factory: :item
    association :invoice, factory: :invoice
    sequence(:quantity) { |n| n.to_i }
    sequence(:unit_price) { |n| n.to_i }
  end
end
