class Project < ActiveRecord::Base
	type = "project"
	has_many :posts
	has_many :images, as: :imageable, :dependent => :destroy

	accepts_nested_attributes_for :images
	
	scope :recent_projects, -> {where("visible = TRUE").order('projects.created_at DESC')}

	def self.selectprojects
		Project.all.pluck("name","id")
	end

	# def self.portfolio
	# 	resultarray = Array.new
	# 	projects = Project.recent_projects

	# 	projects.each do |p|
	# 		picture = p.images.mainpicture
	# 		resultarray << [p.id,p.name,picture]
	# 	end
	# 	resultarray
	# end

	def self.grid
		array = Array.new
		resultarray = Array.new
		counter = 0
		projects = Project.recent_projects

		projects.each do |p|
			counter += 1
			picture = p.images.mainpicture
			array << [p.id,p.name,picture]
			if counter == 3
				resultarray << array
				array = Array.new
				counter = 0
			end
		end

		resultarray << array
		
		return resultarray
	end

	def has_images?
		Project.joins(:images).where('projects.id = ?', self.id).count > 0
	end

	def has_github?
		!self.github_url.blank?
	end

	def has_appstore?
		!self.appstore_url.blank?
	end

	def has_website?
		!self.url.blank?
	end
end