class AddExpiresAtToTransfers < ActiveRecord::Migration[7.0]
  def change
    add_column :transfers, :expires_at, :datetime
  end
end
