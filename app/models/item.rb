class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id

  validates :unit_price, numericality: {only_integer: true, greater_than: 0}

  belongs_to :merchant
  has_many :invoice_items
end
