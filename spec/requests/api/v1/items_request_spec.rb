require 'rails_helper'

describe "Items API" do
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

  it "sends a list of items" do
    
    get api_v1_items_path

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
  end

  it 'returns the top x items ranked by total revenue generated' do
    create_list(:item, 5)

    get "api/v1/items/most_revenue?quantity=2"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    # expect().to eq
  end

end
