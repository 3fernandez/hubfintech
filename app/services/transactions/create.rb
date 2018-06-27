class Transactions::Create < ApplicationService
  def call
    case @transaction_type.downcase
    when 'transfer'
      Transfer.call(amount, @from_id, @to_id)
    when 'contribution'
      Contribution.call(amount, @to_id)
    when 'reversal'
      Reversal.call(@transaction_code)
    end
  end

  private

  def amount
    BigDecimal(@amount.to_s) if @amount
  end
end
