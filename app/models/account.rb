# == Schema Information
#
# Table name: accounts
#
#  id             :bigint(8)        not null, primary key
#  account_status :integer
#  account_type   :integer
#  ancestry       :string
#  balance        :decimal(5, 2)    default(0.0), not null
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_accounts_on_ancestry  (ancestry)
#

class Account < ApplicationRecord
  has_ancestry
  has_one :person, dependent: :destroy
  accepts_nested_attributes_for :person

  enum account_status: %i[active blocked canceled]
  enum account_type: %i[matrix branch]

  validates :account_status, :account_type, :name, :balance, presence: true
end
