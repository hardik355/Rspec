class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name, default: "", null: false
      t.string :last_name, default: "", null: false
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, default: "", null: false
      t.string :mobile_number, default: "", null: false  
      t.string :mobile_country_code, default: "", null: false
      t.string :main_language, default: "", null: false
      t.text :spoken_languages
      t.timestamps
    end
  end
end
