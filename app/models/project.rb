class Project < ActiveRecord::Base
	type = "project"
	has_many :posts
	has_many :images, as: :imageable, :dependent => :destroy

	accepts_nested_attributes_for :images
	
	#Should be used for all public facing views
	scope :recent_projects, -> {where("visible = TRUE").order('projects.created_at DESC')}

	#Should be used only for Admin functions (shows hidden posts)
	scope :manage_projects, -> {order('projects.created_at DESC')}

	## For URL Friendly Names
	def slug
		name.downcase.gsub(" ", "-").gsub(".","")
	end

	def to_param
		"#{id}-#{slug}"
	end

	#Used to generate an array that can be used for form selectors
	def self.selectprojects
		Project.all.pluck("name","id")
	end

	#Used to generate an array of "3"s for projects
	def self.grid
		array = Array.new
		resultarray = Array.new
		counter = 0
		projects = Project.recent_projects

		projects.each do |p|
			counter += 1
			picture = p.images.mainpicture
			array << [p.to_param,p.name,picture]
			if counter == 3
				resultarray << array
				array = Array.new
				counter = 0
			end
		end

		resultarray << array
		
		return resultarray
	end

	#Returns a true or false if the project has images
	def has_images?
		Project.joins(:images).where('projects.id = ?', self.id).count > 0
	end

	#Returns a true or false if the github_url field is filled in for the project
	def has_github?
		!self.github_url.blank?
	end

	#Returns a true or false if the appstore_url field is filled in for the project
	def has_appstore?
		!self.appstore_url.blank?
	end

	#Returns a true or false if the website_url field is is filled in for the project
	def has_website?
		!self.url.blank?
	end
end