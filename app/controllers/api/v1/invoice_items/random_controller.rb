class Api::V1::InvoiceItems::RandomController < ApplicationController
  def show
    invoice_item = InvoiceItem.limit(1).order(Arel.sql("RANDOM()")).first
    render json: InvoiceItemSerializer.new(invoice_item)
  end

end
