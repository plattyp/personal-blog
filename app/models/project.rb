class Project < ActiveRecord::Base
	type = "project"
	has_many :posts
	has_many :images, as: :imageable
end
