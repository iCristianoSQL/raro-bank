class CreateBalance < ActiveRecord::Migration[7.0]
  def change
    create_table :balances do |t|
      t.decimal :withdrawn, precision: 8, scale: 2, null: false, default: 0
      t.decimal :balance_deposited, precision: 8, scale: 2, null: false, default: 0
      t.decimal :current_balance, precision: 8, scale: 2, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
