require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe 'Relationships' do
    it {should have_many :invoices}
  end

  describe 'Class Methods' do
    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)

      it '.top_merchants' do


        expect(Merchant.top_merchants).to eq([@merchant_3, @merchant_2, @merchant_1])
      end
    end
  end

  describe 'Instance Methods' do
    xit '.favorite_merchant' do
      customer = create(:customer)

      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      invoice_1 = create(:invoice, customer: customerinvoices, merchant: merchant_1)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant_1)
      invoice_3 = create(:invoice, customer: customer, merchant: merchant_2)

      success_transaction_1 = create(:success_transaction, invoice: invoice_1)
      success_transaction_2 = create(:success_transaction, invoice: invoice_2)

      failed_transaction_1 = create(:transaction, invoice: invoice_3)
      success_transaction_3 = create(:success_transaction, invoice: invoice_3)

      expect(customer.favorite_merchant).to eq(merchant_1)
      # returns a merchant where the customer has conducted the most successful transactions
    end
  end
end
