class Transactions::Contribution < ApplicationService
  def initialize(amount, to)
    @amount = amount
    @to = Account.find(to) if to
  end

  def call
    ActiveRecord::Base.transaction do
      transaction = AccountTransaction.create!(amount: @amount, to_id: @to.id,
                                                transaction_type: :contribution)
      @to.update(balance: add_balance)
      transaction.reload
    end
  end

  private

  def add_balance
    BigDecimal(@to.balance.to_s) + @amount
  end
end
