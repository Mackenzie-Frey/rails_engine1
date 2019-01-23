class Transaction < ApplicationRecord
  validates_presence_of :invoice_id, :credit_card_number, :result

  validates :credit_card_number, numericality: {only_integer: true}

  # belongs_to :invoice
end
