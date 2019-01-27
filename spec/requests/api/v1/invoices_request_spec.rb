require 'rails_helper'

describe "Invoices API" do
  it "Sends a list of invoices" do
    create_list(:invoice, 4)

    get '/api/v1/invoices'

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
    i2 = create(:invoice, customer: c1, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i3 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

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
    i2 = create(:invoice, customer: c2, merchant: m1, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i3 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

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
    i3 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find_all?status=shipped"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["id"]).to eq(i2.id.to_s)
    expect(invoices["data"][1]["id"]).to eq(i3.id.to_s)
    expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(c2.id)
  end

  it 'Multi Finder - Created_At' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "not shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i3 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find_all?created_at=#{i2.created_at}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["type"]).to eq("invoice")
    expect(invoices["data"][1]["type"]).to eq("invoice")
  end

  it 'Multi Finder - Updated_At' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "not shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-13 16:54:10 UTC", updated_at: "2013-03-07 12:54:10 UTC")

    get "/api/v1/invoices/find_all?updated_at=#{i2.updated_at}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["type"]).to eq("invoice")
    expect(invoices["data"][1]["type"]).to eq("invoice")
  end

end

describe 'Relationship Endpoints - Invoices' do
  it 'returns a collection of associated transactions' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    t1 = create(:transaction, invoice: i1, credit_card_number: "4580251236515201", result: "success", created_at: "2012-05-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    t2 = create(:transaction, invoice: i2, credit_card_number: "4580251236515333", result: "failed", created_at: "2012-03-22 14:54:09 UTC", updated_at: "2015-03-27 14:54:09 UTC")
    t3 = create(:transaction, invoice: i2, credit_card_number: "458025123651533", result: "failed", created_at: "2012-03-22 14:54:10 UTC", updated_at: "2015-03-27 14:54:09 UTC")

    get "/api/v1/invoices/#{i2.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"][0]["type"]).to eq("transaction")
    expect(transactions["data"][1]["type"]).to eq("transaction")
  end

  it 'Returns a collection of associated Invoice_Items' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    invoice_1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    invoice_2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m2)

    ii1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 100, unit_price: 2, created_at: "2012-03-13 16:54:10 UTC", updated_at: "2011-03-07 12:54:10 UTC")
    ii2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 200, unit_price: 3, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")
    ii3 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 300, unit_price: 4, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")

    t1 = create(:transaction, invoice: invoice_1, credit_card_number: "4580251236515201", result: "success", created_at: "2012-05-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    t2 = create(:transaction, invoice: invoice_2, credit_card_number: "4580251236515333", result: "failed", created_at: "2012-03-22 14:54:09 UTC", updated_at: "2015-03-27 14:54:09 UTC")
    t3 = create(:transaction, invoice: invoice_2, credit_card_number: "458025123651533", result: "failed", created_at: "2012-03-22 14:54:10 UTC", updated_at: "2015-03-27 14:54:09 UTC")

    get "/api/v1/invoices/#{invoice_2.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]["type"]).to eq("invoice_item")
    expect(invoice_items["data"][1]["type"]).to eq("invoice_item")
  end

  it 'Returns a collection of associated items' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    invoice_1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    invoice_2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m2)

    ii1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 100, unit_price: 2, created_at: "2012-03-13 16:54:10 UTC", updated_at: "2011-03-07 12:54:10 UTC")
    ii2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 200, unit_price: 3, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")
    ii3 = create(:invoice_item, item: item_1, invoice: invoice_2, quantity: 300, unit_price: 4, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")

    t1 = create(:transaction, invoice: invoice_1, credit_card_number: "4580251236515201", result: "success", created_at: "2012-05-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    t2 = create(:transaction, invoice: invoice_2, credit_card_number: "4580251236515333", result: "failed", created_at: "2012-03-22 14:54:09 UTC", updated_at: "2015-03-27 14:54:09 UTC")
    t3 = create(:transaction, invoice: invoice_2, credit_card_number: "458025123651533", result: "failed", created_at: "2012-03-22 14:54:10 UTC", updated_at: "2015-03-27 14:54:09 UTC")

    get "/api/v1/invoices/#{invoice_2.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["type"]).to eq("item")
    expect(items["data"][1]["type"]).to eq("item")
  end

  it 'Returns the associated customer' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    invoice_1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    invoice_2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m2)

    ii1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 100, unit_price: 2, created_at: "2012-03-13 16:54:10 UTC", updated_at: "2011-03-07 12:54:10 UTC")
    ii2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 200, unit_price: 3, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")
    ii3 = create(:invoice_item, item: item_1, invoice: invoice_2, quantity: 300, unit_price: 4, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")

    t1 = create(:transaction, invoice: invoice_1, credit_card_number: "4580251236515201", result: "success", created_at: "2012-05-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    t2 = create(:transaction, invoice: invoice_2, credit_card_number: "4580251236515333", result: "failed", created_at: "2012-03-22 14:54:09 UTC", updated_at: "2015-03-27 14:54:09 UTC")
    t3 = create(:transaction, invoice: invoice_2, credit_card_number: "458025123651533", result: "failed", created_at: "2012-03-22 14:54:10 UTC", updated_at: "2015-03-27 14:54:09 UTC")

    get "/api/v1/invoices/#{invoice_2.id}/customer"

    expect(response).to be_successful

    customer = JSON.parse(response.body)
    expect(customer["data"]["type"]).to eq("customer")
    expect(customer["data"]["attributes"]["id"]).to eq(c2.id)
  end

end
