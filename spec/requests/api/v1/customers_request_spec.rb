require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 2)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(2)
  end
end

describe "Customer API - Single Finders" do
  it 'Single finders - ID' do
    c1 = create(:customer, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    c2 = create(:customer, first_name: "Name_2", last_name: "Last Name", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/customers/find?id=#{c1.id}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"]["id"]).to eq("#{c1.id}")
    expect(customers["data"]["attributes"]["first_name"]).to eq("#{c1.first_name}")
    expect(customers["data"]["attributes"]["last_name"]).to eq("#{c1.last_name}")
  end

  it 'Single finders - first_name' do
    c1 = create(:customer, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    c2 = create(:customer, first_name: "Name_2", last_name: "Last Name", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/customers/find?first_name=#{c1.first_name}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"]["id"]).to eq("#{c1.id}")
    expect(customers["data"]["attributes"]["first_name"]).to eq("#{c1.first_name}")
    expect(customers["data"]["attributes"]["last_name"]).to eq("#{c1.last_name}")
  end

  it 'Single finders - last_name' do
    c1 = create(:customer, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    c2 = create(:customer, first_name: "Name_2", last_name: "Last Name", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/customers/find?last_name=#{c1.last_name}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"]["id"]).to eq("#{c1.id}")
    expect(customers["data"]["attributes"]["first_name"]).to eq("#{c1.first_name}")
    expect(customers["data"]["attributes"]["last_name"]).to eq("#{c1.last_name}")
  end

  it 'Single finders - created_at' do
    c1 = create(:customer, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    c2 = create(:customer, first_name: "Name_2", last_name: "Last Name", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/customers/find?created_at=#{c1.created_at}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"]["id"]).to eq("#{c1.id}")
    expect(customers["data"]["attributes"]["first_name"]).to eq("#{c1.first_name}")
    expect(customers["data"]["attributes"]["last_name"]).to eq("#{c1.last_name}")
  end

  it 'Single finders - updated_at' do
    c1 = create(:customer, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    c2 = create(:customer, first_name: "Name_2", last_name: "Last Name", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/customers/find?updated_at=#{c1.updated_at}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"]["id"]).to eq("#{c1.id}")
    expect(customers["data"]["attributes"]["first_name"]).to eq("#{c1.first_name}")
    expect(customers["data"]["attributes"]["last_name"]).to eq("#{c1.last_name}")
  end
end

describe "Customer API - Multi-Finders" do
  it 'Multi-finders - ID' do
    c1 = create(:customer, id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    c2 = create(:customer, id: 2, first_name: "First Name", last_name: "Last Name", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/customers/find_all?id=#{c1.id}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"][0]["id"]).to eq("#{c1.id}")
    expect(customers["data"][0]["attributes"]["first_name"]).to eq("#{c1.first_name}")
    expect(customers["data"][0]["attributes"]["last_name"]).to eq("#{c1.last_name}")
  end

  it 'Multi-finders - First Name' do
    c1 = create(:customer, id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    c2 = create(:customer, id: 2, first_name: "Joey", last_name: "Last Name", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/customers/find_all?first_name=#{c1.first_name}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"][0]["id"]).to eq("#{c1.id}")
    expect(customers["data"][1]["id"]).to eq("#{c2.id}")
    expect(customers["data"][0]["attributes"]["first_name"]).to eq("#{c1.first_name}")
    expect(customers["data"][1]["attributes"]["first_name"]).to eq("#{c2.first_name}")
    expect(customers["data"][0]["attributes"]["last_name"]).to eq("#{c1.last_name}")
    expect(customers["data"][1]["attributes"]["last_name"]).to eq("#{c2.last_name}")
  end

  it 'Multi-finders - Last Name' do
    c1 = create(:customer, id: 1, first_name: "Joey", last_name: "Smith", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    c2 = create(:customer, id: 2, first_name: "Ben", last_name: "Smith", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/customers/find_all?last_name=#{c1.last_name}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"][0]["id"]).to eq("#{c1.id}")
    expect(customers["data"][1]["id"]).to eq("#{c2.id}")
    expect(customers["data"][0]["attributes"]["first_name"]).to eq("#{c1.first_name}")
    expect(customers["data"][1]["attributes"]["first_name"]).to eq("#{c2.first_name}")
    expect(customers["data"][0]["attributes"]["last_name"]).to eq("#{c1.last_name}")
    expect(customers["data"][1]["attributes"]["last_name"]).to eq("#{c2.last_name}")
  end

  it 'Multi-finders - Created At' do
    c1 = create(:customer, id: 1, first_name: "Joey", last_name: "Smith", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    c2 = create(:customer, id: 2, first_name: "Ben", last_name: "smoe", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/customers/find_all?created_at=#{c1.created_at}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(2)
    expect(customers["data"][0]["type"]).to eq("customer")
    expect(customers["data"][1]["type"]).to eq("customer")
    expect(customers["data"][0]["id"]).to eq("#{c1.id}")
    expect(customers["data"][1]["id"]).to eq("#{c2.id}")
    expect(customers["data"][0]["attributes"]["first_name"]).to eq("#{c1.first_name}")
    expect(customers["data"][1]["attributes"]["first_name"]).to eq("#{c2.first_name}")
    expect(customers["data"][0]["attributes"]["last_name"]).to eq("#{c1.last_name}")
    expect(customers["data"][1]["attributes"]["last_name"]).to eq("#{c2.last_name}")
  end

  it 'Multi-finders - Updated At' do
    c1 = create(:customer, id: 1, first_name: "Joey", last_name: "Smith", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    c2 = create(:customer, id: 2, first_name: "Ben", last_name: "smoe", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/customers/find_all?updated_at=#{c1.updated_at}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(2)
    expect(customers["data"][0]["type"]).to eq("customer")
    expect(customers["data"][1]["type"]).to eq("customer")
    expect(customers["data"][0]["id"]).to eq("#{c1.id}")
    expect(customers["data"][1]["id"]).to eq("#{c2.id}")
    expect(customers["data"][0]["attributes"]["first_name"]).to eq("#{c1.first_name}")
    expect(customers["data"][1]["attributes"]["first_name"]).to eq("#{c2.first_name}")
    expect(customers["data"][0]["attributes"]["last_name"]).to eq("#{c1.last_name}")
    expect(customers["data"][1]["attributes"]["last_name"]).to eq("#{c2.last_name}")
  end

end

describe 'Relationship Endpoints - Customers' do
  it 'Returns a collection of associated invoices' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")
    i3 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    t1 = create(:transaction, invoice: i1, credit_card_number: "4580251236515201", result: "success", created_at: "2012-05-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    t2 = create(:transaction, invoice: i2, credit_card_number: "4580251236515333", result: "failed", created_at: "2012-03-22 14:54:09 UTC", updated_at: "2015-03-27 14:54:09 UTC")
    t3 = create(:transaction, invoice: i2, credit_card_number: "458025123651533", result: "failed", created_at: "2012-03-22 14:54:10 UTC", updated_at: "2015-03-27 14:54:09 UTC")

    get "/api/v1/customers/#{c2.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["type"]).to eq("invoice")
    expect(invoices["data"][1]["type"]).to eq("invoice")
  end

  it 'Returns a collection of associated transactions' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")
    i3 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    t1 = create(:transaction, invoice: i1, credit_card_number: "4580251236515201", result: "success", created_at: "2012-05-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    t2 = create(:transaction, invoice: i2, credit_card_number: "4580251236515333", result: "failed", created_at: "2012-03-22 14:54:09 UTC", updated_at: "2015-03-27 14:54:09 UTC")
    t3 = create(:transaction, invoice: i3, credit_card_number: "458025123651533", result: "failed", created_at: "2012-03-22 14:54:10 UTC", updated_at: "2015-03-27 14:54:09 UTC")

    get "/api/v1/customers/#{c2.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"][0]["type"]).to eq("transaction")
    expect(transactions["data"][1]["type"]).to eq("transaction")
  end

end
