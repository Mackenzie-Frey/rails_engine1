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

  xit 'returns the top x items ranked by total revenue generated' do

    get "api/v1/items/most_revenue?quantity=2"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    # below -> is this how I want to test it.
    expect(items).to eq([@item_3, @item_2])
  end

end

describe "Items API - Single Finders" do
  it 'Single Finder - ID' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?id=#{i1.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"]).to eq(i1.id.to_s)
    expect(items["data"]["attributes"]["merchant_id"]).to eq(m1.id)
  end

  it 'Single Finder - Name' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?name=#{item1.name}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"]).to eq(i1.id.to_s)
    expect(items["data"]["attributes"]["merchant_id"]).to eq(m1.id)
  end

  it 'Single Finder - Description' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?description=#{item1.description}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(1)
    expect(items["data"]["id"]).to eq(i2.id.to_s)
    expect(items["data"]["attributes"]["customer_id"]).to eq(c2.id)
  end

  it 'Single Finder - Unit_Price' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?unit_price=#{item1.unit_price}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(1)
    expect(items["data"]["id"]).to eq(i2.id.to_s)
    expect(items["data"]["attributes"]["customer_id"]).to eq(c2.id)
  end

  it 'Single Finder - Merchant_Id' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?merchant_id=#{m1.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"]).to eq(i1.id.to_s)
    expect(items["data"]["attributes"]["customer_id"]).to eq(c1.id)
  end


  it 'Single Finder - Created_At' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?created_at=#{i1.created_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"]).to eq(i1.id.to_s)
    expect(items["data"]["attributes"]["customer_id"]).to eq(c1.id)
  end

  it 'Single Finder - Updated_At' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?updated_at=#{i1.updated_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"]).to eq(i1.id.to_s)
    expect(items["data"]["attributes"]["customer_id"]).to eq(c1.id)
  end

end

describe "Items API - Multi Finders" do
  it 'Multi Finder - ID' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?id=#{i1.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(1)
    expect(items["data"][0]["id"]).to eq(i1.id.to_s)
    expect(items["data"][0]["attributes"]["merchant_id"]).to eq(m1.id)
  end

  it 'Multi Finder - Name' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?customer_id=#{c1.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["id"]).to eq(i1.id.to_s)
    expect(items["data"][0]["attributes"]["merchant_id"]).to eq(m1.id)
  end

  it 'Multi Finder - Merchant_Id' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?merchant_id=#{m1.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["id"]).to eq(i1.id.to_s)
    expect(items["data"][0]["attributes"]["customer_id"]).to eq(c1.id)
  end

  it 'Multi Finder - Description' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?description=#{item1.description}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["id"]).to eq(i2.id.to_s)
    expect(items["data"][1]["id"]).to eq(i3.id.to_s)
    expect(items["data"][0]["attributes"]["customer_id"]).to eq(c2.id)
  end

  it 'Multi Finder - Unit_Price' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?unit_price=#{item1.unit_price}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(1)
    expect(items["data"]["id"]).to eq(i2.id.to_s)
    expect(items["data"]["attributes"]["customer_id"]).to eq(c2.id)
  end


  it 'Multi Finder - Created_At' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?created_at=#{i2.created_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["type"]).to eq("invoice")
    expect(items["data"][1]["type"]).to eq("invoice")
  end

  it 'Multi Finder - Updated_At' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?updated_at=#{i2.updated_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["type"]).to eq("invoice")
    expect(items["data"][1]["type"]).to eq("invoice")
  end


end
