class PostsController < ApplicationController
  def index
    @posts = Post.recent_posts
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
