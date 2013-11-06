class CreateAdminUser < ActiveRecord::Migration
  User.create!(full_name: "Admin", login: "admin", birthday: "2013-10-01", address: "Statue of Liberty", city: "New York", state: "NY", country: "United States", zip: 10001, email: "admin@example.com", password: "administrator", role_id: 1)
end
