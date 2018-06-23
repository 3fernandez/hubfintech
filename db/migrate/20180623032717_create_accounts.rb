class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :account_type
      t.integer :account_status
      t.string :name
      t.decimal :balance, precision: 5, scale: 2, default: 0.0, null: false
      t.string :ancestry

      t.timestamps
    end
    add_index :accounts, :ancestry
  end
end
