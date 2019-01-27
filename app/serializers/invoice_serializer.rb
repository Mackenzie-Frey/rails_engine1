class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions
  attributes :id, :customer_id, :merchant_id, :status
end
