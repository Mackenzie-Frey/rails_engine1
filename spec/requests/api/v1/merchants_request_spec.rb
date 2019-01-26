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

  it 'Single finders - Name' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find?name=#{m1.name}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq("#{m1.id}")
    expect(merchants["data"]["attributes"]["name"]).to eq("#{m1.name}")
  end

  it 'Single finders - Created At' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find?created_at=#{m1.created_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq("#{m1.id}")
    expect(merchants["data"]["attributes"]["name"]).to eq("#{m1.name}")
  end

  it 'Single finders - Updated At' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find?updated_at=#{m1.updated_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq("#{m1.id}")
    expect(merchants["data"]["attributes"]["name"]).to eq("#{m1.name}")
  end
end

describe "Customer API - Multi-Finders" do
  it 'Multi-finders - ID' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find_all?id=#{m1.id}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"][0]["id"]).to eq("#{m1.id}")
    expect(merchants["data"][0]["attributes"]["name"]).to eq("#{m1.name}")
  end

  it 'Multi finders - Name' do
    m1 = create(:merchant, name: "M", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")
    m3 = create(:merchant, name: "M3", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find_all?name=#{m1.name}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["id"]).to eq("#{m1.id}")
    expect(merchants["data"][1]["id"]).to eq("#{m2.id}")
    expect(merchants["data"][0]["attributes"]["name"]).to eq("#{m1.name}")
    expect(merchants["data"][1]["attributes"]["name"]).to eq("#{m2.name}")
  end

  it 'Multi finders - Created At' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")
    m3 = create(:merchant, name: "M3", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find_all?created_at=#{m1.created_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["id"]).to eq("#{m1.id}")
    expect(merchants["data"][1]["id"]).to eq("#{m2.id}")
    expect(merchants["data"][0]["attributes"]["name"]).to eq("#{m1.name}")
    expect(merchants["data"][1]["attributes"]["name"]).to eq("#{m2.name}")
  end

  it 'Multi finders - Updated At' do
    m1 = create(:merchant, name: "M1", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m2 = create(:merchant, name: "M2", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    m3 = create(:merchant, name: "M3", created_at: "2012-04-27 14:54:09 UTC", updated_at: "2012-04-27 14:54:09 UTC")

    get "/api/v1/merchants/find_all?updated_at=#{m1.updated_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["id"]).to eq("#{m1.id}")
    expect(merchants["data"][1]["id"]).to eq("#{m2.id}")
    expect(merchants["data"][0]["attributes"]["name"]).to eq("#{m1.name}")
    expect(merchants["data"][1]["attributes"]["name"]).to eq("#{m2.name}")
  end

end
