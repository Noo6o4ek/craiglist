FactoryGirl.define do
  factory :user do
    login 'user'
    email { |n| "user#{n}@example.com" }
    password 'pasSw0rd!'
    password_confirmation 'pasSw0rd!'
    full_name 'User'
    user_role { UserRoles.find_by_name('user') }
    address "4 Pennsylvania Plaza"
    city "New York"
    state "NY"
    zip 10001
    country "United States"
    birthday Time.now
  end

  factory :admin, class: User do
    login 'admin'
    email { |n| "user#{n}@example.com" }
    password 'pasSw0rd!'
    password_confirmation 'pasSw0rd!'
    full_name 'Administrator'
    user_role { UserRoles.find_by_name('admin') }
    birthday Time.now
    country "United States"
    address "175 5th Ave"
    city "New York"
    state "NY"
    zip 10010
  end

  factory :moderator, class: User do
    login 'moderator'
    email { |n| "user#{n}@example.com" }
    password 'pasSw0rd!'
    password_confirmation 'pasSw0rd!'
    full_name 'Moderator'
    user_role { UserRoles.find_by_name('moderator') }
    birthday Time.now
    country "Ukraine"
    address "Pobedi, 37"
    city "Kiev"
    state "Kiev"
    zip 03056
  end
end
