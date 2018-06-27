# == Schema Information
#
# Table name: account_transactions
#
#  id               :bigint(8)        not null, primary key
#  amount           :decimal(5, 2)    default(0.0)
#  transaction_code :string
#  transaction_type :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  from_id          :integer
#  to_id            :integer
#
# Indexes
#
#  index_account_transactions_on_from_id           (from_id)
#  index_account_transactions_on_to_id             (to_id)
#  index_account_transactions_on_transaction_code  (transaction_code) UNIQUE
#

class AccountTransaction < ApplicationRecord
  belongs_to :from, class_name: 'Account', foreign_key: :from_id, optional: true
  belongs_to :to, class_name: 'Account', foreign_key: :to_id

  enum transaction_type: %i[transfer contribution reversal]

  validates :transaction_code, presence: true, uniqueness: true
  validates :amount, presence: true
  validates_with FundsValidator, unless: :contribution?
  validates_with AccountStatusValidator

  before_validation :gen_unique_code, unless: :transaction_code?

  private

  def gen_unique_code
    self.transaction_code = SecureRandom.hex(3)
  end
end
