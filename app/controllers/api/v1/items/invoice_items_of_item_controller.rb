class Api::V1::Items::InvoiceItemsOfItemController < ApplicationController

  def show
    render json: InvoiceItemSerializer.new(Item.find_by(look_up_params).invoice_items)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
