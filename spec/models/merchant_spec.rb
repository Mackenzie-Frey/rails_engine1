require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :name}
  end

  describe 'Relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
  end

  describe 'Class Methods' do
    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)

      @invoice_1 = create(:invoice, merchant: @merchant_1)
      @invoice_2 = create(:invoice, merchant: @merchant_2)
      @invoice_3 = create(:invoice, merchant: @merchant_2)
      @invoice_4 = create(:invoice, merchant: @merchant_3)
      @invoice_5 = create(:invoice, merchant: @merchant_3)
      @invoice_6 = create(:invoice, merchant: @merchant_3)

      @item_1 = create(:item, merchant:@merchant_1)
      @item_2 = create(:item, merchant:@merchant_2)
      @item_3 = create(:item, merchant:@merchant_3)

      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 10, unit_price: 100)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 10, unit_price: 100)
      @invoice_item_3 = create(:invoice_item, item: @item_2, invoice: @invoice_3, quantity: 10, unit_price: 100)
      @invoice_item_4 = create(:invoice_item, item: @item_3, invoice: @invoice_4, quantity: 10, unit_price: 100)
      @invoice_item_5 = create(:invoice_item, item: @item_3, invoice: @invoice_5, quantity: 10, unit_price: 100)
      @invoice_item_6 = create(:invoice_item, item: @item_3, invoice: @invoice_6, quantity: 10, unit_price: 100)
      @invoice_item_7 = create(:invoice_item, item: @item_3, invoice: @invoice_6, quantity: 10, unit_price: 100)

      @success_transaction_1 = create(:success_transaction, invoice: @invoice_1)
      @success_transaction_2 = create(:success_transaction, invoice: @invoice_2)
      @success_transaction_3 = create(:success_transaction, invoice: @invoice_3)
      @success_transaction_4 = create(:success_transaction, invoice: @invoice_4)
      @success_transaction_5 = create(:success_transaction, invoice: @invoice_5)
      @success_transaction_6 = create(:success_transaction, invoice: @invoice_6)

      @failed_transaction_4 = create(:transaction, invoice: @invoice_4)
    end
      it '.highest_revenue(count)' do

        expect(Merchant.highest_revenue(2)).to eq([@merchant_3, @merchant_2])
      end

      it '.most_items_sold(count)' do

        expect(Merchant.most_items_sold(2)).to eq([@merchant_3, @merchant_2])
      end


  end
end
