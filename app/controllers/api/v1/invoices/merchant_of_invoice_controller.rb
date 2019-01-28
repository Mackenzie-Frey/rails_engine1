class Api::V1::Invoices::MerchantOfInvoiceController < ApplicationController

  def show
    render json: MerchantSerializer.new(Invoice.find_by(look_up_params).merchant)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
