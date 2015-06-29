class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def create
    @user = User.create(user_params)
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  private
  def user_params
    params.require(:user).permit(:avatar, :avatar_url)
  end

end
