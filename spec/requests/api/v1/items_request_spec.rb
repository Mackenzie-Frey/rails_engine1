require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    invoice_1 = create(:invoice, merchant: merchant_1)
    invoice_2 = create(:invoice, merchant: merchant_2)
    invoice_3 = create(:invoice, merchant: merchant_2)
    invoice_4 = create(:invoice, merchant: merchant_3)
    invoice_5 = create(:invoice, merchant: merchant_3)
    invoice_6 = create(:invoice, merchant: merchant_3)

    item_1 = create(:item, merchant:merchant_1)
    item_2 = create(:item, merchant:merchant_2)
    item_3 = create(:item, merchant:merchant_3)

    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 10, unit_price: 100)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 10, unit_price: 100)
    invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_3, quantity: 10, unit_price: 100)
    invoice_item_4 = create(:invoice_item, item: item_3, invoice: invoice_4, quantity: 10, unit_price: 100)
    invoice_item_5 = create(:invoice_item, item: item_3, invoice: invoice_5, quantity: 10, unit_price: 100)
    invoice_item_6 = create(:invoice_item, item: item_3, invoice: invoice_6, quantity: 10, unit_price: 100)
    invoice_item_7 = create(:invoice_item, item: item_3, invoice: invoice_6, quantity: 10, unit_price: 100)

    success_transaction_1 = create(:success_transaction, invoice: invoice_1)
    success_transaction_2 = create(:success_transaction, invoice: invoice_2)
    success_transaction_3 = create(:success_transaction, invoice: invoice_3)
    success_transaction_4 = create(:success_transaction, invoice: invoice_4)
    success_transaction_5 = create(:success_transaction, invoice: invoice_5)
    success_transaction_6 = create(:success_transaction, invoice: invoice_6)

    failed_transaction_4 = create(:transaction, invoice: invoice_4)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
  end

end

describe "Items API - Single Finders" do
  it 'Single Finder - ID' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?id=#{i1.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"]).to eq(i1.id.to_s)
    expect(items["data"]["attributes"]["name"]).to eq(i1.name)
  end

  it 'Single Finder - Name' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?name=#{i1.name}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"]).to eq(i1.id.to_s)
    expect(items["data"]["attributes"]["name"]).to eq(i1.name)
  end

  it 'Single Finder - Description' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?description=#{i1.description}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(1)
    expect(items["data"]["id"]).to eq(i1.id.to_s)
    expect(items["data"]["attributes"]["description"]).to eq(i1.description)
  end

  it 'Single Finder - Unit_Price' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?unit_price=#{i1.unit_price}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(1)
    expect(items["data"]["id"]).to eq(i1.id.to_s)
    expect(items["data"]["attributes"]["unit_price"]).to eq(i1.unit_price)
  end

  it 'Single Finder - Merchant_Id' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?merchant_id=#{m1.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"]).to eq(i1.id.to_s)
    expect(items["data"]["attributes"]["merchant_id"]).to eq(m1.id)
  end

  it 'Single Finder - Created_At' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?created_at=#{i1.created_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"]).to eq(i1.id.to_s)
  end

  it 'Single Finder - Updated_At' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find?updated_at=#{i1.updated_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"]).to eq(i1.id.to_s)
  end

end

describe "Items API - Multi Finders" do
  it 'Multi Finder - ID' do
    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?id=#{i1.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(1)
    expect(items["data"][0]["type"]).to eq("item")
    expect(items["data"][0]["id"]).to eq(i1.id.to_s)
    expect(items["data"][0]["attributes"]["merchant_id"]).to eq(m1.id)
  end

  it 'Multi Finder - Name' do
    m1 = create(:merchant)
    m2 = create(:merchant)
    m3 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")
    i3 = create(:item, name: "item_name", description: "desc3", unit_price: 300, merchant: m3, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2017-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?name=#{i2.name}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["type"]).to eq("item")
    expect(items["data"][1]["type"]).to eq("item")
    expect(items["data"][0]["id"]).to eq(i2.id.to_s)
    expect(items["data"][1]["id"]).to eq(i3.id.to_s)
    expect(items["data"][0]["attributes"]["merchant_id"]).to eq(m2.id)
  end

  it 'Multi Finder - Merchant_Id' do
    m1 = create(:merchant)
    m2 = create(:merchant)
    m3 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")
    i3 = create(:item, name: "item_3_name", description: "desc3", unit_price: 300, merchant: m2, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2017-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?merchant_id=#{m2.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["type"]).to eq("item")
    expect(items["data"][1]["type"]).to eq("item")
    expect(items["data"][0]["id"]).to eq(i2.id.to_s)
    expect(items["data"][1]["id"]).to eq(i3.id.to_s)
  end

  it 'Multi Finder - Description' do
    m1 = create(:merchant)
    m2 = create(:merchant)
    m3 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")
    i3 = create(:item, name: "item_3_name", description: "desc", unit_price: 300, merchant: m3, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2017-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?description=#{i2.description}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["type"]).to eq("item")
    expect(items["data"][1]["type"]).to eq("item")
    expect(items["data"][0]["id"]).to eq(i2.id.to_s)
    expect(items["data"][1]["id"]).to eq(i3.id.to_s)
  end

  it 'Multi Finder - Unit_Price' do
    m1 = create(:merchant)
    m2 = create(:merchant)
    m3 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")
    i3 = create(:item, name: "item_3_name", description: "desc3", unit_price: 200, merchant: m3, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2017-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?unit_price=#{i2.unit_price}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["type"]).to eq("item")
    expect(items["data"][1]["type"]).to eq("item")
    expect(items["data"][0]["id"]).to eq(i2.id.to_s)
  end

  it 'Multi Finder - Created_At' do
    m1 = create(:merchant)
    m2 = create(:merchant)
    m3 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")
    i3 = create(:item, name: "item_3_name", description: "desc3", unit_price: 300, merchant: m3, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2017-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?created_at=#{i2.created_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["type"]).to eq("item")
    expect(items["data"][1]["type"]).to eq("item")
  end

  it 'Multi Finder - Updated_At' do
    m1 = create(:merchant)
    m2 = create(:merchant)
    m3 = create(:merchant)

    i1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")
    i3 = create(:item, name: "item_3_name", description: "desc3", unit_price: 300, merchant: m3, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    get "/api/v1/items/find_all?updated_at=#{i2.updated_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["type"]).to eq("item")
    expect(items["data"][1]["type"]).to eq("item")
  end

end

describe 'Business Intelligence Endpoint - Items' do
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

    it 'Items - Returns the top x items ranked by total revenue generated' do

      get '/api/v1/items/most_revenue?quantity=2'

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(2)
      expect(items["data"][0]["type"]).to eq("item")
      expect(items["data"][1]["type"]).to eq("item")
      expect(items["data"][1]["type"]).to eq("item")
      expect(items["data"][0]["id"]).to eq("#{@item_3.id}")
      expect(items["data"][1]["id"]).to eq("#{@item_2.id}")
    end

    it 'Items - Returns the top x item instances ranked by total number sold' do

      get '/api/v1/items/most_items?quantity=2'

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(2)
      expect(items["data"][0]["type"]).to eq("item")
      expect(items["data"][1]["type"]).to eq("item")
      expect(items["data"][1]["type"]).to eq("item")
      expect(items["data"][0]["id"]).to eq("#{@item_3.id}")
      expect(items["data"][1]["id"]).to eq("#{@item_2.id}")
    end

end

describe 'Relationship Endpoints - Items' do
  it 'Returns a collection of associated invoice items' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    invoice1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    invoice2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")
    invoice3 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")
    item3 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    ii1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 100, unit_price: 2, created_at: "2012-03-13 16:54:10 UTC", updated_at: "2011-03-07 12:54:10 UTC")
    ii2 = create(:invoice_item, item: item1, invoice: invoice2, quantity: 200, unit_price: 3, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")
    ii3 = create(:invoice_item, item: item3, invoice: invoice3, quantity: 200, unit_price: 4, created_at: "2016-04-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")

    get "/api/v1/items/#{item1.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]["type"]).to eq("invoice_item")
    expect(invoice_items["data"][1]["type"]).to eq("invoice_item")
    expect(invoice_items["data"][0]["id"]).to eq(ii1.id.to_s)
  end

end
