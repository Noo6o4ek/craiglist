class AddUserIdImageToAdverts < ActiveRecord::Migration
  def self.up
    add_column :adverts, :user_id, :integer
  end

  def self.down
    remove_column :adverts, :user_id
  end
end
