FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "default_#{n}" }
  end
end
