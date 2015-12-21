class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :login
      t.date :date_of_birth
      t.boolean :disabled, default: false, null: false

      t.timestamps null: false
    end
  end
end
