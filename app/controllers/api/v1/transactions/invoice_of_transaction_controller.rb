class Api::V1::Transactions::InvoiceOfTransactionController < ApplicationController

  def show
    render json: InvoiceSerializer.new(Transaction.find_by(look_up_params).invoice)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
