class Api::V1::Customers::TransactionsOfCustomerController < ApplicationController

  def index
    render json: TransactionSerializer.new(Customer.find_by(look_up_params).find_transactions)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
