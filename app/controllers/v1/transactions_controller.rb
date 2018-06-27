class V1::TransactionsController < ApplicationController
  def index
    transactions = AccountTransaction.all
    render json: transactions, status: :ok
  end

  def show
    transaction = AccountTransaction.find(params[:id])
    render json: transaction, status: :ok
  end

  def create
    transaction = Transactions::Create.call(transactions_params)
    render json: transaction, status: :created
  end

  private

  def transactions_params
    params.require(:transaction)
          .permit(:amount, :from_id, :to_id,
                  :transaction_code, :transaction_type)
  end
end
