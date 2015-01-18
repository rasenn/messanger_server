require 'factory_girl'

FactoryGirl.define do
  factory :user1, class: User do
    id 1
    name "Test User1"
    email "user1@test.com"
    password "password"
    password_confirmation "password"
  end

  factory :user2, class: User do
    id 2
    name "Test User2"
    email "user2@test.com"
    password "password"
    password_confirmation "password"
  end

  factory :user3, class: User do
    id 3
    name "Test User3"
    email "user3@test.com"
    password "password"
    password_confirmation "password"
  end
end
