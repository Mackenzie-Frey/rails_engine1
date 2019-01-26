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
