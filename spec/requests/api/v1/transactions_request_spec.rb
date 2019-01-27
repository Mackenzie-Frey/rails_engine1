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

describe "Transactions API - Single Finders" do
  it 'Single Finder - ID' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)

    i1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    i2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    t1 = create(:transaction, invoice: i1, credit_card_number: "4580251236515201", result: "success", created_at: "2012-05-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    t2 = create(:transaction, invoice: i2, credit_card_number: "4580251236515333", result: "failed", created_at: "2012-03-22 14:54:09 UTC", updated_at: "2015-03-27 14:54:09 UTC")

    get "/api/v1/transactions/find?id=#{t1.id}"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"]["id"]).to eq(t1.id.to_s)
  end
end
