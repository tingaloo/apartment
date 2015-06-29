class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :about]
  respond_to :html, :js
  before_action :render_posts, only: [:index, :create, :update, :destroy]

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

    respond_to do |format|
      if @post.update(post_params)
        format.html {redirect_to @post, notice: "Post created"}
          format.js { }
          format.json {render json: @post }
      else
        format.html {render action: "edit"}
          format.json {render json: @post.errors }
      end
    end

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end

  private

  def render_posts
    @posts = Post.paginate(page: params[:page], per_page: 4).order(created_at: :desc)
  end

  def set_posts
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :categories)
  end
end
