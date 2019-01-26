require 'rails_helper'

describe "Merchants API" do
  xit "sends a list of merchants" do
    create_list(:merchant, 6)

    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(6)
  end
end
