class Category < ActiveRecord::Base
  has_many :posts

  scope :categories_with_counts, -> { order('categories.name ASC').joins('LEFT JOIN posts ON posts.category_id = categories.id').select('categories.id,categories.name,count(posts.id) AS postcount').group('categories.id,categories.name') }

  # Used to populate the an array to populate a select for a form
  def self.selectcategories
    Category.all.pluck('name', 'id')
  end
end
