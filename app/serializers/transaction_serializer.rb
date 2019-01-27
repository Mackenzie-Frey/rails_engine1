class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :invoice
  attributes :id, :invoice_id, :credit_card_number, :result, :credit_card_expiration_date
end
