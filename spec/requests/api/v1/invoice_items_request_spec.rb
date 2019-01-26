require 'rails_helper'

describe "Invoice Items API" do
  xit "sends a list of invoice items" do
    create_list(:invoice_item, 3)

    get api_v1_invoice_items_path

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
  end
end
