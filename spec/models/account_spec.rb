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

require 'rails_helper'

RSpec.describe Account, type: :model do
  it do
    should define_enum_for(:account_status)
      .with(%i[active blocked canceled])
  end

  it do
    should define_enum_for(:account_type)
      .with(%i[matrix branch])
  end

  it { should validate_presence_of(:account_status) }
  it { should validate_presence_of(:account_type) }
  it { should validate_presence_of(:balance) }
  it { should validate_presence_of(:name) }
end
