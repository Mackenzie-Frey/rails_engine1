require 'rails_helper'

describe "customers API" do
  it "sends a list of customers" do
    create(:customer)
    create(:customer)

    api_v1_customers_path
    
    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(2)
  end
end
