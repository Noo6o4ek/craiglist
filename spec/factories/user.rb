FactoryGirl.define do
  factory :user do
    login 'user'
    email 'user@example.com'
    password 'pasSw0rd!'
    password_confirmation 'pasSw0rd!'
    full_name 'User'
    role_id { ::UserRoles.where(name: 'user').first.id }
    address "4 Pennsylvania Plaza"
    city "New York"
    state "NY"
    zip 10001
    country "United States"
  end

  factory :admin, class: User do
    login 'admin'
    email 'admin@example.com'
    password 'pasSw0rd!'
    password_confirmation 'pasSw0rd!'
    full_name 'Administrator'
    role_id { ::UserRoles.where(name: 'admin').first.id }
  end

  factory :moderator, class: User do
    login 'moderator'
    email 'moderator@example.com'
    password 'pasSw0rd!'
    password_confirmation 'pasSw0rd!'
    full_name 'Moderator'
    role_id { ::UserRoles.where(name: 'moderator').first.id }
  end
end
