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

require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  it do
    should define_enum_for(:transaction_type)
      .with(%i[transfer contribution reversal])
  end

  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:transaction_code) }
  it { should validate_uniqueness_of(:transaction_code) }
end
