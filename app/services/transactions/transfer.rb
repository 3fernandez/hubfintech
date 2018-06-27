class Transactions::Transfer < ApplicationService
  def initialize(amount, from, to)
    @amount = amount
    @from = Account.find(from) if from
    @to = Account.find(to) if to
  end

  def call
    ActiveRecord::Base.transaction do
      transaction = AccountTransaction.create!(amount: @amount, from_id: @from.id,
                                               to_id: @to.id, transaction_type: :transfer)
      @to.update!(balance: add_balance)
      @from.update!(balance: subtract_balance)
      transaction.reload
    end
  end

  private

  def add_balance
    BigDecimal(@to.balance.to_s) + @amount
  end

  def subtract_balance
    BigDecimal(@from.balance.to_s) - @amount
  end
end
