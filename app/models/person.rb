# == Schema Information
#
# Table name: people
#
#  id          :bigint(8)        not null, primary key
#  birthdate   :date
#  cnpj        :string
#  cpf         :string
#  full_name   :string
#  social_name :string
#  trade_name  :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint(8)
#
# Indexes
#
#  index_people_on_account_id  (account_id)
#  index_people_on_type        (type)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#

class Person < ApplicationRecord
  belongs_to :account

  scope :corporations, -> { where(type: 'Corporation') }
  scope :individuals, -> { where(type: 'Individual') }
end
