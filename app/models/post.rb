class Post < ActiveRecord::Base
  type = 'post'
  belongs_to :user
  belongs_to :category
  has_many :images, as: :imageable, dependent: :destroy
  belongs_to :project

  accepts_nested_attributes_for :images

  # Should be used for all public facing views
  scope :recent_posts, ->(category_id = nil) { category_id ? where('category_id = ? AND visible = TRUE', category_id).order('posts.created_at DESC') : where('visible = TRUE').order('posts.created_at DESC') }

  # Should be used only for Admin functions (shows hidden posts)
  scope :manage_posts, ->(category_id = nil) { category_id ? where('category_id = ?', category_id).order('posts.created_at DESC') : order('posts.created_at DESC') }

  # Validations
  validates :category_id, :name, :content, :user_id, presence: true

  ## For URL Friendly Names
  def slug
    name.downcase.tr(' ', '-').delete('.')
  end

  def to_param
    "#{id}-#{slug}"
  end

  # Returns true or false if the post has a main picture
  def has_profilepic?
    profile_pic != nil
  end

  # Returns true or false if the post has any images
  def has_images?
    Post.joins(:images).where('posts.id = ?', id).count > 0
  end

  # Returns true or false if the post has a project that is visible
  def has_project?
    !project_id.nil? && project.visible
  end

  # Increments the likes attribute on the Post and saves it
  def like
    self.likes += 1
    save
  end

  private

  # Returns back the profile pic for the post or Picture indicated as the Main Pic Indicator as true
  def profile_pic
    Post.joins(:images).where('posts.id = ? AND images.mainpicindicator = ?', id, true).first
  end
end
