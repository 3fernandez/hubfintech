class FundsValidator < ActiveModel::Validator
  def validate(record)
    from = Account.find(record.from_id) if record.from_id
    if BigDecimal(record.amount.to_s) > BigDecimal(from.balance.to_s)
      record.errors.add(:base, 'You do not have enough funds to transfer')
    end
  end
end
