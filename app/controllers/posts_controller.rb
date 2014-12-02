class PostsController < ApplicationController
  before_filter :get_metadata
  def index
    @posts = Post.recent_posts(params[:category])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), flash[:notice] => "The post has been saved!"
    else
      redirect_to new_post_path, flash[:notice] => "The post could not be saved, sorry"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:name,:content,:user_id,:project_id,:title,:category)
  end
end
