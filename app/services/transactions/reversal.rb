class Transactions::Reversal < ApplicationService
  def initialize(transaction_code)
    @transaction = AccountTransaction.where(transaction_code: transaction_code).first
    @from = Account.find(@transaction.from_id)
    @to = Account.find(@transaction.to_id)
  end

  def call
    ActiveRecord::Base.transaction do
      transaction = AccountTransaction.create!(amount: amount, from_id: @to.id,
                                               to_id: @from.id, transaction_type: :reversal)
      @from.update!(balance: add_balance)
      @to.update!(balance: subtract_balance)
      transaction.reload
    end
  end

  private

  def add_balance
    BigDecimal(@from.balance.to_s) + amount
  end

  def subtract_balance
    BigDecimal(@to.balance.to_s) - amount
  end

  def amount
    BigDecimal(@transaction.amount.to_s)
  end
end
