class Api::V1::Merchants::ItemsOfMerchantController < ApplicationController

  def index
    merchant = render json: MerchantSerializer.new(Merchant.find_by(look_up_params))

    render json: ItemSerializer.new(Item.where(merchant["data"]["id"] = look_up_params))
  end

  private
    def look_up_params
      params.permit(:id)
    end

end


# items = Merchant.find(params{;id].items
#   render json Assocaited Items serializer

# rails g serializer AssociatedItem
