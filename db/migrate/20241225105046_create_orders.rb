class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :browser_ip
      t.string :cancel_reason
      t.datetime :cancelled_at
      t.string :currency
      t.integer :quantity

      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
