class Api::V1::InvoiceItems::ItemOfInvoiceItemController < ApplicationController

  def show
    render json: ItemSerializer.new(InvoiceItem.find_by(look_up_params).item)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
