FactoryBot.define do
  factory :user do
    name { "Jonathan" }
    email { "jonathan.edward.hall@gmail.com" }
    password { "whatever" }
    password_confirmation { "whatever" }
  end
end
