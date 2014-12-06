class Project < ActiveRecord::Base
	type = "project"
	has_many :posts
	has_many :images, as: :imageable
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
end