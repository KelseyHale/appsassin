require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :game do
    user
    sequence(:name) { |n| "Point Blank#{n}" }
    password "johncusack"
  end

  factory :player do
    user
    game
  end
end
