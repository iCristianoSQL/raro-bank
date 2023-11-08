class CreateFees < ActiveRecord::Migration[7.0]
  def change
    create_table :fees do |t|
      t.string :name, null: false, limit: 100, unique: true
      t.float :value, null: false, inclusion: { in: 0..100, message: "Deve estar entre 0 e 100" }
      t.date :latest_release, null: false

      t.timestamps
    end
  end
end
