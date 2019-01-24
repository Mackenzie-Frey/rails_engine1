class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.top_merchants
    # binding.pry
    # Merchant
    # .joins()
    # .select("merchants.name, sum(invoice_item.quantity * invoice_item.unit_price) AS merchant_revenue JOIN invoices ON merchant.id = invoices.merchant_id JOIN invoice_items ON invoices.id = invoice_items.invoice_id JOIN transactions ON invoices.id = transactions.invoice_id")
    # .where("transactions.result = 'success'")
    # .group("merchants.id")
    # .order("merchants.merchant_revenue DESC")
  end
end
