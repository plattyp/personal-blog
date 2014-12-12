class Category < ActiveRecord::Base
	has_many :posts

	scope :all_categories, -> {order('categories.name ASC')}

	def self.selectcategories
		Category.all.pluck("name","id")
	end
end
