class Project < ActiveRecord::Base
	type = "project"
	has_many :posts
	has_many :images, as: :imageable
	scope :recent_projects, -> {order('projects.created_at DESC')}

	def self.selectprojects
		Project.all.pluck("name","id")
	end
end
