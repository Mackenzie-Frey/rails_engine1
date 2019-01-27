require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 6)

    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(6)
  end
end

describe "Merchant API - Single Finders" do
  it 'Single finders - ID' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find?id=#{m1.id}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq("#{m1.id}")
    expect(merchants["data"]["attributes"]["name"]).to eq("#{m1.name}")
  end

  it 'Single finders - Name' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find?name=#{m1.name}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq("#{m1.id}")
    expect(merchants["data"]["attributes"]["name"]).to eq("#{m1.name}")
  end

  it 'Single finders - Created At' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find?created_at=#{m1.created_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq("#{m1.id}")
    expect(merchants["data"]["attributes"]["name"]).to eq("#{m1.name}")
  end

  it 'Single finders - Updated At' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find?updated_at=#{m1.updated_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq("#{m1.id}")
    expect(merchants["data"]["attributes"]["name"]).to eq("#{m1.name}")
  end
end

describe "Mechant API - Multi-Finders" do
  it 'Multi-finders - ID' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find_all?id=#{m1.id}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"][0]["id"]).to eq("#{m1.id}")
    expect(merchants["data"][0]["attributes"]["name"]).to eq("#{m1.name}")
  end

  it 'Multi finders - Name' do
    m1 = create(:merchant, name: "M", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")
    m3 = create(:merchant, name: "M3", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find_all?name=#{m1.name}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["id"]).to eq("#{m1.id}")
    expect(merchants["data"][1]["id"]).to eq("#{m2.id}")
    expect(merchants["data"][0]["attributes"]["name"]).to eq("#{m1.name}")
    expect(merchants["data"][1]["attributes"]["name"]).to eq("#{m2.name}")
  end

  it 'Multi finders - Created At' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")
    m3 = create(:merchant, name: "M3", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find_all?created_at=#{m1.created_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["type"]).to eq("merchant")
    expect(merchants["data"][1]["type"]).to eq("merchant")
    expect(merchants["data"][0]["id"]).to eq("#{m1.id}")
    expect(merchants["data"][1]["id"]).to eq("#{m2.id}")
    expect(merchants["data"][0]["attributes"]["name"]).to eq("#{m1.name}")
    expect(merchants["data"][1]["attributes"]["name"]).to eq("#{m2.name}")
  end

  it 'Multi finders - Updated At' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m3 = create(:merchant, name: "M3", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find_all?updated_at=#{m1.updated_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["type"]).to eq("merchant")
    expect(merchants["data"][1]["type"]).to eq("merchant")
    expect(merchants["data"][0]["id"]).to eq("#{m1.id}")
    expect(merchants["data"][1]["id"]).to eq("#{m2.id}")
    expect(merchants["data"][0]["attributes"]["name"]).to eq("#{m1.name}")
    expect(merchants["data"][1]["attributes"]["name"]).to eq("#{m2.name}")
  end

end

describe 'Merchant Business Intelligence Endpoints' do
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

    it 'All Merchants - Returns the top x merchants ranked by total revenue' do

      get '/api/v1/merchants/most_revenue?quantity=2'

      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants["data"].count).to eq(2)
      expect(merchants["data"][0]["type"]).to eq("merchant")
      expect(merchants["data"][1]["type"]).to eq("merchant")
      expect(merchants["data"][1]["type"]).to eq("merchant")
      expect(merchants["data"][0]["id"]).to eq("#{@merchant_3.id}")
      expect(merchants["data"][1]["id"]).to eq("#{@merchant_2.id}")
    end
end
