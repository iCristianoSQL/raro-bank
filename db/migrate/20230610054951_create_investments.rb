class CreateInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments do |t|
      t.decimal :invested_amount, precision: 8, scale: 2
      t.date :investment_date
      t.boolean :redeemed, default: false
      t.date :redemption_date
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
