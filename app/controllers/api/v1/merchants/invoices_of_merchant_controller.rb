class Api::V1::Merchants::InvoicesOfMerchantController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Merchant.find_by(look_up_params).invoices)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
