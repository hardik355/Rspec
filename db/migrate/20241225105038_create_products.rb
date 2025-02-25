class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.text :description
      t.string :handle
      t.integer :status
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
