class Api::V1::Transactions::RandomController < ApplicationController
  def show
    transaction = Transaction.limit(1).order(Arel.sql("RANDOM()")).first
    render json: TransactionSerializer.new(transaction)
  end

end
