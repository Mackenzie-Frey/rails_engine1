class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.top_merchants(n)
    Merchant
    .joins(invoices: :invoice_items)
    .joins(invoices: :transactions)
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS merchant_revenue")
    .where("transactions.result = 'success'")
    .group(:id)
    .order("merchant_revenue DESC")
    .limit(n)
  end
end
