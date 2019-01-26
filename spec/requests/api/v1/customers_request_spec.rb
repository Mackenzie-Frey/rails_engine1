require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 2)

    get api_v1_customers_path

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
end
