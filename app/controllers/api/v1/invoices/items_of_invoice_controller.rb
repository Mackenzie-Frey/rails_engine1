class Api::V1::Invoices::ItemsOfInvoiceController < ApplicationController

  def index
    render json: ItemSerializer.new(InvoiceItem.where(Invoice.find_by(look_up_params)).items)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
