FactoryBot.define do
  factory :user do
    name { 'tester' }
    sequence(:email) { |n| "#{name.downcase}+#{n}@test.com" }
    password { 'whatever' }
    password_confirmation { 'whatever' }
  end

  factory: :admin do
    name { 'tester' }
    sequence(:email) { |n| "#{name.downcase}+#{n}@test.com" }
    password { 'whatever' }
    password_confirmation { 'whatever' }
    association :role
  end
end
