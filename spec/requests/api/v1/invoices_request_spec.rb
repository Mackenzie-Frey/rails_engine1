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

  it 'Single Finder - Merchant_Id' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find?merchant_id=#{m1.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"]["id"]).to eq(i1.id.to_s)
    expect(invoices["data"]["attributes"]["customer_id"]).to eq(c1.id)
  end

  it 'Single Finder - Status' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "not shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find?status=shipped"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(1)
    expect(invoices["data"]["id"]).to eq(i2.id.to_s)
    expect(invoices["data"]["attributes"]["customer_id"]).to eq(c2.id)
  end

  it 'Single Finder - Created_At' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "not shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find?created_at=#{i1.created_at}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"]["id"]).to eq(i1.id.to_s)
    expect(invoices["data"]["attributes"]["customer_id"]).to eq(c1.id)
  end

  it 'Single Finder - Updated_At' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "not shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find?updated_at=#{i1.updated_at}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"]["id"]).to eq(i1.id.to_s)
    expect(invoices["data"]["attributes"]["customer_id"]).to eq(c1.id)
  end

end

describe "Invoices API - Multi Finders" do
  it 'Multi Finder - ID' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find_all?id=#{i1.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(1)
    expect(invoices["data"][0]["id"]).to eq(i1.id.to_s)
    expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(m1.id)
  end

  it 'Multi Finder - Customer_Id' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find_all?customer_id=#{c1.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["id"]).to eq(i1.id.to_s)
    expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(m1.id)
  end

  it 'Multi Finder - Merchant_Id' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find_all?merchant_id=#{m1.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["id"]).to eq(i1.id.to_s)
    expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(c1.id)
  end

  it 'Multi Finder - Status' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "not shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find_all?status=shipped"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(1)
    expect(invoices["data"][0]["id"]).to eq(i2.id.to_s)
    expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(c2.id)
  end

  it 'Multi Finder - Created_At' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "not shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find_all?created_at=#{i1.created_at}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["id"]).to eq(i1.id.to_s)
    expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(c1.id)
  end

  it 'Multi Finder - Updated_At' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "not shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find_all?updated_at=#{i1.updated_at}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["id"]).to eq(i1.id.to_s)
    expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(c1.id)
  end

end
