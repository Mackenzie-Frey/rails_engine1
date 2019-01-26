require 'rails_helper'

describe "Customers API" do
  xit "sends a list of customers" do
    create_list(:customer, 2)

    get api_v1_customers_path

    expect(response).to be_successful

    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(2)
  end

  xit 'Single finders - ID' do

    get '/api/v1/customers/find?id=2'


  end
end

# do for customers first test, routing, serializing. hand roll routes (rewrite
# index, show, first name , last name, create_at, updated at
# complete single and multi for one fulla resource
# check every time in local host, copy path and paste into local,
