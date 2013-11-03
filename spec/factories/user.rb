FactoryGirl.define do
  factory :admin_user, class: User do
    login 'admin'
    email 'admin@example.com'
    password 'pasSw0rd!'
    password_confirmation 'pasSw0rd!'
    full_name 'Administrator'
    user_role 1
    addresss "Donetsk"
  end
end
