class Post < ActiveRecord::Base
	type = "post"
	belongs_to :user
	belongs_to :category
	has_many :images, as: :imageable, :dependent => :destroy
	belongs_to :project

	accepts_nested_attributes_for :images

	scope :recent_posts, ->(category_id = nil) {category_id ? where("category_id = ?", category_id).order('posts.created_at DESC') : order('posts.created_at DESC') }
	validates :category_id, :name, :content, presence: true

	def profile_pic
		#profilepic = Post.joins('LEFT OUTER JOIN images ON posts.id = images.imageable_id').where('images.imageable_type = ? AND posts.id = ?',"post",self.id).select('image_url').first
		profilepic = Post.joins(:images).where('posts.id = ? AND images.mainpicindicator = ?', self.id, true).first
	end

	def has_profilepic?
		profile_pic != nil
	end

	def has_images?
		Post.joins(:images).where('posts.id = ?', self.id).count > 0
	end

	def has_project?
		self.project_id != nil
	end
end
