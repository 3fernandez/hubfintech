class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :type
      t.string :cnpj
      t.string :cpf
      t.string :social_name
      t.string :trade_name
      t.string :full_name
      t.date :birthdate
      t.references :account, foreign_key: true

      t.timestamps
    end
    add_index :people, :type
  end
end
