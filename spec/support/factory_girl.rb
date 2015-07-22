require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:first_name) { |n| "James#{n}" }
    last_name 'Bond'
  end

  factory :game do
    user
    sequence(:name) { |n| "Point Blank#{n}" }
    password "johncusack"
    limit 2
  end

  factory :player do
    user
    game
  end
end
