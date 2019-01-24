class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.top_merchants
    binding.pry
    # Merchant
    # .select(merchants .* JOIN)
    # .joins(:invoices)
    # .joins("")
    # .sum()
    # .order(total_revenue)
  end
end
