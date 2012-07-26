class UsersController < ApplicationController
  before_filter :admin?, :except => :show

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User updated successfully!"
      redirect_to user_path
    else
      render 'edit'
    end
  end

  private
    def admin?
      redirect_to root_path unless current_user.admin
    end
end