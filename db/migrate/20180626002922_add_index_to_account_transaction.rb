class AddIndexToAccountTransaction < ActiveRecord::Migration[5.2]
  def change
    add_index :account_transactions, :transaction_code, unique: true
  end
end
