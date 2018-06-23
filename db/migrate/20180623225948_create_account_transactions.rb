class CreateAccountTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :account_transactions do |t|
      t.integer :transaction_type
      t.string :transaction_code
      t.decimal :amount, precision: 5, scale: 2, default: 0.0
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
    add_index :account_transactions, :from_id
    add_index :account_transactions, :to_id
  end
end
