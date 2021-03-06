require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.password 'password'
    f.password_confirmation 'password'
    f.signupcode Rails.application.secrets.signupcode
  end
end
