class Api::V1::Items::MerchantOfItemController < ApplicationController

  def show
    render json: MerchantSerializer.new(Item.find_by(look_up_params).merchant)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
