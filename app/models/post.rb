class Post < ActiveRecord::Base
	type = "post"
	belongs_to :user
	belongs_to :category
	has_many :images, as: :imageable
	belongs_to :project

	scope :recent_posts, ->(category_id = nil) {category_id ? where("category_id = ?", category_id).order('posts.created_at DESC') : order('posts.created_at DESC') }
	validates :category_id, :name, :title, presence: true

	def profile_pic
		Post.joins('LEFT OUTER JOIN images ON images.imageable_id = posts.id').where('images.imageable_type = ?',"post").select('image_url').first
	end
end
