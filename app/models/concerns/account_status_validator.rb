class AccountStatusValidator < ActiveModel::Validator
  def validate(record)
    to = Account.find(record.to_id) if record.to_id
    message = 'Only active accounts can receive transfers or contributions'
    record.errors.add(:base, message) unless to.active?
  end
end
