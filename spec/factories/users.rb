FactoryBot.define do
  factory :user do
    firstname "Test"
    lastname "User"
    displayname "Test User"
    role "client"
    email "test@example.com"
    password "passwd123"
  end
end
