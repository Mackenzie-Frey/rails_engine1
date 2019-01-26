require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 5)

    get api_v1_items_path

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(5)
  end
end
