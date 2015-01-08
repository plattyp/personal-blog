require 'faker'

FactoryGirl.define do 
	factory :image do |f|
		f.imageable_id 1
		f.imageable_type "project"
		f.mainpicindicator false
		f.caption { Faker::Lorem.sentence }
		f.image File.new(Rails.root + 'spec/factories/images/image.png')
	end
end