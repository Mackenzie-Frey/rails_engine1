require 'rails_helper'

describe "Invoices API" do
  it "Sends a list of invoices" do
    create_list(:invoice, 4)

    get api_v1_invoices_path

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(4)
  end
end

describe "Invoices API - Single Finders" do
  it 'Single Finder - ID' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find?id=#{i1.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"]["id"]).to eq(i1.id.to_s)
    expect(invoices["data"]["attributes"]["merchant_id"]).to eq(m1.id)
  end

  it 'Single Finder - Customer_Id' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find?customer_id=#{c1.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"]["id"]).to eq(i1.id.to_s)
    expect(invoices["data"]["attributes"]["merchant_id"]).to eq(m1.id)
  end
end
