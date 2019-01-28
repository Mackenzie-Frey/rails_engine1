 class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id, :status

  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions

  def find_items
    invoice_items.map do |ii|
      Item.find(ii.item_id)
    end
  end
end
