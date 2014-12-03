class Project < ActiveRecord::Base
	type = "project"
	has_many :posts
	has_many :images, as: :imageable

	def self.selectprojects
		Project.all.pluck("name","id")
	end
end
