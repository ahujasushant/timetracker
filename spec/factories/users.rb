FactoryBot.define do
  factory :user do
    name 'Sushant'
    sequence(:email) { |n| "something#{n}@something.com"}
    password 'Abcd#1234'
  end
end
