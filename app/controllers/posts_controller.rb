class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:author_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.includes(posts: :comments).find(params[:author_id])
    @post = Post.find(params[:id])
    @posts = @user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = user.id
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_posts_path(@user, @post)
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
