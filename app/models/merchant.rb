class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.highest_revenue(n)
    joins(invoices: :invoice_items)
    .joins(invoices: :transactions)
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS merchant_revenue")
    .where("transactions.result = 'success'")
    .group(:id)
    .order("merchant_revenue DESC")
    .limit(n)
  end

  def self.most_items_sold(n)
    joins(invoices: :invoice_items)
    .joins(invoices: :transactions)
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS quantity_sold")
    .where("transactions.result = 'success'")
    .group(:id)
    .order("quantity_sold DESC")
    .limit(n)
  end
end
