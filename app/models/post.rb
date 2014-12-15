class Post < ActiveRecord::Base
	type = "post"
	belongs_to :user
	belongs_to :category
	has_many :images, as: :imageable, :dependent => :destroy
	belongs_to :project

	accepts_nested_attributes_for :images

	#Should be used for all public facing views
	scope :recent_posts, ->(category_id = nil) {category_id ? where("category_id = ? AND visible = TRUE", category_id).order('posts.created_at DESC') : where("visible = TRUE").order('posts.created_at DESC') }
	
	#Should be used only for Admin functions (shows hidden posts)
	scope :manage_posts, ->(category_id = nil) {category_id ? where("category_id = ?", category_id).order('posts.created_at DESC') : order('posts.created_at DESC') }
	validates :category_id, :name, :content, presence: true

	def profile_pic
		profilepic = Post.joins(:images).where('posts.id = ? AND images.mainpicindicator = ?', self.id, true).first
	end

	def has_profilepic?
		profile_pic != nil
	end

	def has_images?
		Post.joins(:images).where('posts.id = ?', self.id).count > 0
	end

	def has_project?
		self.project_id != nil && self.project.visible
	end

	def like
		self.likes += 1
		self.save
	end
end
