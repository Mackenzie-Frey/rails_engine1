require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe 'Relationships' do
    it {should have_many :invoices}
  end

  describe 'Instance Methods' do
    xit '.favorite_merchant' do
      customer = create(:customer)

      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant_1)
      invoice_3 = create(:invoice, customer: customer, merchant: merchant_2)

      success_transaction_1 = create(:success_transaction, invoice: invoice_1)
      success_transaction_2 = create(:success_transaction, invoice: invoice_2)

      failed_transaction_1 = create(:transaction, invoice: invoice_3)
      success_transaction_3 = create(:success_transaction, invoice: invoice_3)

      expect(customer.favorite_merchant).to eq(merchant_1)
      # returns a merchant where the customer has conducted the most successful transactions
    end

    it '.find_transactions' do
      c1 = create(:customer)
      c2 = create(:customer)

      m1 = create(:merchant)
      m2 = create(:merchant)

      i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
      i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

      t1 = create(:transaction, invoice: i1, credit_card_number: "4580251236515201", result: "success", created_at: "2012-05-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
      t2 = create(:transaction, invoice: i2, credit_card_number: "4580251236515333", result: "failed", created_at: "2012-03-22 14:54:09 UTC", updated_at: "2015-03-27 14:54:09 UTC")
      t3 = create(:transaction, invoice: i2, credit_card_number: "458025123651533", result: "failed", created_at: "2012-03-22 14:54:10 UTC", updated_at: "2015-03-27 14:54:09 UTC")

      expect(c2.find_transactions).to eq([t2, t3])
    end
  end

end
