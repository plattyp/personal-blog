class Category < ActiveRecord::Base
	has_many :posts

	def self.selectcategories
		Category.all.pluck("name","id")
	end
end
