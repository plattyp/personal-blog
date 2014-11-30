class Post < ActiveRecord::Base
	has_one :user
	has_many :images

	scope :recent_posts, -> { order('posts.created_at') }
end
