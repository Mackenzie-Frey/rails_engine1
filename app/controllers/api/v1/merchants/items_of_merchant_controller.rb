class Api::V1::Merchants::ItemsOfMerchantController < ApplicationController

  def index
    render json: ItemSerializer.new(Merchant.find_by(look_up_params).items)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
