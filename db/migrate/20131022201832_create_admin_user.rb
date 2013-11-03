class CreateAdminUser < ActiveRecord::Migration
  # user = User.create!(full_name: "Admin", login: "admin", email: "admin@example.com", password: "administrator", role_id: 1)
  user = User.create!(full_name: "Admin", login: "admin", birthday: "2013-10-01", address: "Donetsk", city: "Donetsk", state: "Donetsk", country: "Ukraine", zip: 83012, email: "admin@example.com", password: "administrator", role_id: 1)
  puts user.inspect
end
