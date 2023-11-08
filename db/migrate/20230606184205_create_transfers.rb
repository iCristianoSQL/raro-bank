# frozen_string_literal: true

class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.bigint 'sender_id', null: false
      t.bigint 'receiver_id', null: false
      t.decimal 'amount', precision: 8, scale: 2, null: false, default: 0
      t.string 'token'
      t.integer 'status', null: false
      t.index ['sender_id'], name: 'index_transfers_on_sender_id'
      t.index ['receiver_id'], name: 'index_transfers_on_receiver_id'

      t.timestamps
    end
  end
end
