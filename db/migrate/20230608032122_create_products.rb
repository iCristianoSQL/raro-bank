class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, unique: true, length: { minimum: 4, maximum: 20 }
      t.integer :punctuation, default: 0
      t.date :start_date, default: -> { "CURRENT_DATE" }
      t.date :end_of_term, null: false
      t.decimal :minimum_investment_amount, null: false
      t.string :image_url, null: false
      t.boolean :premium, default: false
      t.float :additional_fee, null: false
      t.references :fee, foreign_key: true

      t.timestamps
    end
  end
end
