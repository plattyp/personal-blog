require 'faker'

FactoryGirl.define do 
	factory :image do |f|
		f.imageable_id 1
		f.imageable_type "project"
		f.mainpicindicator false
		f.caption { Faker::Lorem.sentence }
		f.image File.new(Rails.root + 'spec/factories/images/image.png')

		factory :main_image do
			mainpicindicator true
		end

		factory :non_main_image do
			mainpicindicator false
		end
	end
end