class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :account_status, :account_type, :balance
  has_one :person
end
