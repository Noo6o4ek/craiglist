class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :login
      t.date :birthday
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :zip

      t.timestamps
    end
  end
end
