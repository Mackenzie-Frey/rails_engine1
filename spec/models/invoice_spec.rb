require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :customer_id}
    it {should validate_presence_of :merchant_id}
    it {should validate_presence_of :status}
  end

  describe 'Relationships' do
    it {should belong_to :customer}
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many :transactions}
  end
end

describe 'Instance Methods' do
  it '.find_items' do
    c1 = create(:customer)
    c2 = create(:customer)

    m1 = create(:merchant)
    m2 = create(:merchant)
    
    invoice_1 = create(:invoice, customer: c1, merchant: m1, status: "shipped", created_at: "2012-03-14 16:54:10 UTC", updated_at: "2012-03-02 12:54:10 UTC")
    invoice_2 = create(:invoice, customer: c2, merchant: m2, status: "shipped", created_at: "2013-03-17 16:54:10 UTC", updated_at: "2013-03-01 12:54:10 UTC")

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m2)

    ii1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 100, unit_price: 2, created_at: "2012-03-13 16:54:10 UTC", updated_at: "2011-03-07 12:54:10 UTC")
    ii2 = create(:invoice_item, item: item_2, invoice: invoice_1, quantity: 200, unit_price: 3, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")
    ii3 = create(:invoice_item, item: item_1, invoice: invoice_2, quantity: 300, unit_price: 4, created_at: "2016-03-13 16:54:10 UTC", updated_at: "2014-03-07 12:54:10 UTC")

    expect(invoice_1.find_items).to eq([item_1, item_2])
  end
end
