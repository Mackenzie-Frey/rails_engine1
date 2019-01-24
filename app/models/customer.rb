class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices

  def favorite_merchant
    # Merchant
    # # .select("merchants.* FROM merchants")
    # # .joins("invoices ON invoices.merchant_id = merchants.id")
    # .joins(:transactions)
    # .where("merchant_id")
    #
    # .order("transaction_count DESC")
    # .limit(1)

  end

  def self.top_merchants
    binding.pry
    # Merchant.joins(invoices: :transactions)
  end
end
