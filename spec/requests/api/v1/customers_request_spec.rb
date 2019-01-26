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
  before :each do
    c2 = create(:customer, first_name: "Name_2", last_name: "Last Name", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")
  end

  it 'Single finders - ID' do
    c1 = create(:customer, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/customers/find?id=#{c1.id}"

    expect(response).to be_successful
  end
end

# do for customers first test, routing, serializing. hand roll routes (rewrite
# index, show, first name , last name, create_at, updated at
# complete single and multi for one fulla resource
# check every time in local host, copy path and paste into local,
