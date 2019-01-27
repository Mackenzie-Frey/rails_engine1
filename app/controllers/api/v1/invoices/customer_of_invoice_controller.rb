class Api::V1::Invoices::CustomerOfInvoiceController < ApplicationController

  def show
    render json: CustomerSerializer.new(Invoice.find_by(look_up_params).customer)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
