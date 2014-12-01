class Post < ActiveRecord::Base
	type = "post"
	belongs_to :user
	has_many :images, as: :imageable
	belongs_to :project

	scope :recent_posts, -> { order('posts.created_at DESC') }
end
