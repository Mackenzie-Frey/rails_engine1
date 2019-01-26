class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.find_by(look_up_params))
    #right about after .find_by, look up maybe sql to pul in there
  end

  private

  def look_up_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
