class Project < ActiveRecord::Base
	type = "project"
	has_many :posts
	has_many :images, as: :imageable, :dependent => :destroy

	accepts_nested_attributes_for :images
	
	scope :recent_projects, -> {order('projects.created_at DESC')}

	def self.selectprojects
		Project.all.pluck("name","id")
	end

	def self.portfolioprojects
		array = Array.new
		resultarray = Array.new
		counter = 0
		projects = selectprojects

		projects.each do |p|
			counter += 1
			puts "counter #{counter}"
			array << p
			puts "#{array}"
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