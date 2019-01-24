FactoryBot.define do
  factory :transaction do
    invoice
    sequence(:credit_card_number) { |n| 9999999999999999 - n }
    credit_card_expiration_date { nil }
    result { "failed" }
  end

  factory :success_transaction, parent: :transaction do
    invoice
    sequence(:credit_card_number) { |n| 9999999999999999 - n }
    credit_card_expiration_date { nil }
    result { "success" }
  end
end
