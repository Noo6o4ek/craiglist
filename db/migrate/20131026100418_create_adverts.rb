class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.text :description
      t.timestamps
    end
  end
end
