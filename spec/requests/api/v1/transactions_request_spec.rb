require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 7)

    get api_v1_transactions_path

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(7)
  end
end
