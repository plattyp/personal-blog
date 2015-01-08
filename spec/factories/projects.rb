require 'faker'

FactoryGirl.define do 
	factory :project do |f|
		f.name { Faker::Lorem.sentence }
		f.github_url { Faker::Internet.url }
		f.description { Faker::Lorem.paragraph }
		f.url { Faker::Internet.url }
		f.appstore_url { Faker::Internet.url }
		f.snippet { Faker::Lorem.paragraph }
		f.visible true
		f.keywords { Faker::Lorem.sentence }
	end
end