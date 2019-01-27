class Api::V1::Invoices::TransactionsOfInvoiceController < ApplicationController

  def index
    render json: TransactionSerializer.new(Invoice.find_by(look_up_params).transactions)
  end

  private
    def look_up_params
      params.permit(:id)
    end

end
