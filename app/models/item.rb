class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id

  validates :unit_price, numericality: {only_integer: true, greater_than: 0}

  belongs_to :merchant
  has_many :invoice_items

  def self.by_top_revenue(n)
    Item
    .joins(:invoices)
    .joins(:invoice_items)
    .joins(:transations)
    .where("transactions.result = 'success'")
    .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS item_revenue")
    .where("transactions.result = 'success'")
    .group(:id)
    .order("merchant_revenue DESC")
    .limit(n)
  end
end
