json.array!(@users) do |user|
  json.extract! user, :full_name, :login, :email, :birthday, :address, :city, :state, :zip
  json.url user_url(user, format: :json)
end
