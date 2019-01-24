class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.top_merchants
    binding.pry
    # Merchant.joins(invoices: :transactions)
    # .sum()
    # .order
  end
end
