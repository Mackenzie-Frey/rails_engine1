require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 6)

    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(6)
  end
end

describe "Merchant API - Single Finders" do
  it 'Single finders - ID' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find?id=#{m1.id}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq("#{m1.id}")
    expect(merchants["data"]["attributes"]["name"]).to eq("#{m1.name}")
  end
end
