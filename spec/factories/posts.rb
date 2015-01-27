require 'faker'

FactoryGirl.define do 
	factory :post do |f|
		f.name { Faker::Lorem.sentence }
		f.content { Faker::Lorem.paragraph }
		f.user_id 1
		f.category_id 1
		f.project_id nil
		f.visible false
		f.likes { Faker::Number.number(1) }
		f.metadescription { Faker::Lorem.sentence }
		f.metakeywords { Faker::Lorem.sentence }

		factory :invalid_post do
			category_id nil
		end

		factory :visible_post do
			visible true
		end

		factory :invisible_post do
			visible false
		end
	end
end