FactoryGirl.define do
  factory :comment do
    body "Simple comment"
    association :user, factory: :user
    association :advert, factory: :advert
  end
end
