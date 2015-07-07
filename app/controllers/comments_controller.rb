class CommentsController < ApplicationController
  # def new
  #   @comment = current_user.comments.build
  # end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, :notice => "comment saved"
    else
      render '@post'
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:post_id, :title, :body, :categories, :user_id)
  end

end
