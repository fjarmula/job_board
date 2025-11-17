FactoryBot.define do
  factory :user do
    username { "test_user" }
    email_address { "user@example.com" }
    password { "password" }
  end
end
