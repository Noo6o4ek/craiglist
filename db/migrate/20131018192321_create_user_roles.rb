class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.string :name

      t.timestamps
    end

    %w(admin moderator user).each do |role|
      UserRoles.create(name: role)
    end
  end
end
