require 'faker'

FactoryGirl.define do 
	factory :post do |f|
		f.name { Faker::Lorem.sentence }
		f.content { Faker::Lorem.paragraph }
		f.user_id 1
		f.category_id { Faker::Number.number(1) }
		f.project_id { Faker::Number.number(1) }
		f.visible false
		f.likes { Faker::Number.number(1) }
		f.metadescription { Faker::Lorem.sentence }
		f.metakeywords { Faker::Lorem.sentence }
	end
end