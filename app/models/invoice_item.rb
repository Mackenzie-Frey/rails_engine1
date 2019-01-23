class InvoiceItem < ApplicationRecord
  validates_presence_of :item_id, :invoice_id, :quantity, :unit_price

  validates :quantity, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :unit_price, numericality: {greater_than: 0}

  # belongs_to :item
  # belongs_to :invoice
end
