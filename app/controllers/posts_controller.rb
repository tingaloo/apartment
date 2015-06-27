class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :about]
  # respond_to :html, :js
  # before_action :all_posts, only: [:index, :create, :update]

  def index
    @posts = Post.all

  #   respond_to do |format|
  #   format.html
  #   format.json
  # end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build

    # respond_to do |format|
    #   # format.html { redirect_to @post, notice: "format.html"}
    #   format.html { redirect_to root_path }
    #   format.js
    # end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|

      if @post.save
        format.html {redirect_to @post, notice: "Post created"}
        format.js { }
        format.json {render json: @post, status: :created, location: @post }
      else
        format.html {render action: "new"}
        format.json {render json: @post.errors }
      end
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

  # def all_posts
  #   @posts = Post.all
  # end

  def post_params
    params.require(:post).permit(:title, :content, :categories)
  end
end
