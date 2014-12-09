class PostsController < ApplicationController
  before_filter :get_selectors, only: [:new, :edit]
  before_filter :get_metadata
  def index
    @posts = Post.recent_posts(params[:category_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @post.images.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), :notice => "The post has been saved!"
    else
      redirect_to new_post_path, :notice => "The post could not be saved, sorry"
    end
  end

  def edit
    @post = Post.find(params[:id])
    @post.images.build
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to edit_post_path(@post.id), :notice => "The post has been updated!"
    else
      redirect_to edit_post_path(@post.id), :notice => "The post could not be updated!"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to manageposts_path, :notice => "The post has been deleted successfully"
    else
      redirect_to manageposts_path, :notice => "The post was unable to be deleted"
    end
  end

  def manage
    @posts = Post.recent_posts(params[:category])
  end

  private

  def post_params
    params.require(:post).permit(:name,:content,:user_id,:project_id,:category_id,images_attributes: [:id,:image])
  end

  def get_selectors
    @projects = Project.selectprojects
    @categories = Category.selectcategories
  end
end
