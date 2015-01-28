require 'faker'

FactoryGirl.define do 
	factory :project do |f|
		f.name { Faker::Lorem.sentence[0..200] }
		f.github_url { Faker::Internet.url[0..70] }
		f.description { Faker::Lorem.paragraph[0..200] }
		f.url { Faker::Internet.url[0..70] }
		f.appstore_url { Faker::Internet.url[0..70] }
		f.snippet { Faker::Lorem.paragraph[0..200] }
		f.visible true
		f.keywords { Faker::Lorem.sentence[0..200] }

		factory :visible_project do
			visible true
		end

		factory :invisible_project do
			visible false
		end
	end
end