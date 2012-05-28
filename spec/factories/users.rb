# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
  f.sequence(:name) { |n| "name_#{n}" }
  f.sequence(:email) { |n| "login_#{n}@example.com" }
  f.sequence(:password) { |n| "epyfnm" }
  f.password_confirmation { |f| f.password }
  end
end
