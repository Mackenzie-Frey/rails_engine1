class Api::V1::InvoiceItems::InvoiceOfInvoiceItemController < ApplicationController

  def show
    render json: InvoiceSerializer.new(InvoiceItem.find_by(look_up_params).invoice)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
