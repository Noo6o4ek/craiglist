class CreateAdminUser < ActiveRecord::Migration
  User.create(full_name: "Admin", login: "admin", email: "admin@example.com", password: "administrator", role_id: 1)
end
