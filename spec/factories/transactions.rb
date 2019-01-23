FactoryBot.define do
  factory :failed_transaction do
    association :invoice, factory: :invoice
    sequence(:credit_card_number) { |n| 9999999999999999 - n }
    credit_card_expiration_date { null }
    status { "failed" }
  end

  factory :successful_transaction do
    association :invoice, factory: :invoice
    sequence(:credit_card_number) { |n| 9999999999999999 - n }
    credit_card_expiration_date { null }
    status { "success" }
  end
end
