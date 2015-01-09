require 'faker'

FactoryGirl.define do 
	factory :userdetail do |f|
	    f.description { Faker::Lorem.paragraph }
	    f.education { Faker::Lorem.paragraph }
	    f.workexperience { Faker::Lorem.paragraph }
	    f.hobbies { Faker::Lorem.paragraph }
	    f.user_id 1
	    f.github_url { Faker::Internet.url }
	    f.linkedin_url { Faker::Internet.url }
	    f.allowmessages false
	end
end