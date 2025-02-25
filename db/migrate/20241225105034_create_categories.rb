class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :handle
      t.string :body_html
      t.datetime :published_at
      t.string :collection_type
      t.string :rules

      t.timestamps
    end
  end
end
