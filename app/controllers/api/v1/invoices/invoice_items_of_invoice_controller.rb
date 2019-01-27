class Api::V1::Invoices::InvoiceItemsOfInvoiceController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(Invoice.find_by(look_up_params).invoice_items)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
