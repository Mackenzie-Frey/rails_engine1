class Api::V1::Transactions::SearchController < ApplicationController

  def show
    render json: TransactionSerializer.new(Transaction.find_by(look_up_params))
  end

  def index
    render json: TransactionSerializer.new(Transaction.where(look_up_params))
  end

  private
    def look_up_params
      params.permit(:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at)
    end

end
