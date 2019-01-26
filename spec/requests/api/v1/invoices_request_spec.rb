require 'rails_helper'

describe "Invoices API" do
  xit "Sends a list of invoices" do
    create_list(:invoice, 4)

    get api_v1_invoices_path

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(4)
  end
end
