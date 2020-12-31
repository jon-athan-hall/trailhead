FactoryBot.define do
  factory :user do
    name { 'Jonathan' }
    sequence(:email) { |n| "#{name.downcase}+#{n}@test.com" }
    password { 'whatever' }
    password_confirmation { 'whatever' }
  end
end
