class Api::V1::Items::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.by_top_quantity_sold(params[:quantity]))
  end

end
