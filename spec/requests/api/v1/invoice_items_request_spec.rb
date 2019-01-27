require 'rails_helper'

describe "Invoice Items API" do
  it "sends a list of invoice items" do
    create_list(:invoice_item, 3)

    get api_v1_invoice_items_path

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
  end
end

describe "Invoice Items API - Single Finders" do
  it 'Single Finder - ID' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    invoice1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    invoice2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    ii1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 100, unit_price: 2, created_at: "2012-03-13 16:54:10 UTC", updated_at: "2011-03-07 12:54:10 UTC")
    ii2 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 100, unit_price: 2, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")

    get "/api/v1/invoice_items/find?id=#{ii1.id}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"]["id"]).to eq(ii1.id.to_s)
  end

  it 'Single Finder - Customer_Id' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    invoice1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    invoice2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    item1 = create(:item, name: "item_1_name", description: "desc1", unit_price: 100, merchant: m1, created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    item2 = create(:item, name: "item_2_name", description: "desc2", unit_price: 200, merchant: m2, created_at: "2015-03-13 16:54:10 UTC", updated_at: "2015-03-07 12:54:10 UTC")

    ii1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 100, unit_price: 2, created_at: "2012-03-13 16:54:10 UTC", updated_at: "2011-03-07 12:54:10 UTC")
    ii2 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 100, unit_price: 2, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")

    get "/api/v1/invoice_items/find?customer_id=#{c1.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"]["id"]).to eq(ii1.id.to_s)
    end
end
