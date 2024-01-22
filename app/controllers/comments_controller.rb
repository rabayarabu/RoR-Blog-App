class CommentsController < ApplicationController
  def new
    @user = current_user
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:id])
    @comment = @post.comments.build(comment_params.merge(user: @user))

    if @comment.save
      redirect_to @post
    else
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
