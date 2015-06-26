class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :about]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path, notice: "Post Created"
    else
      redirect_to root_path, notice: "Post not saved"
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :categories)
  end
end
