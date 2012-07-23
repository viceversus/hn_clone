class LinksController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :correct_user, only: [:edit, :update]

  def index
    @links = Link.all
    @link = Link.new
  end

  def new
    @link = current_user.links.build(params[:link])
  end

  def create
    if current_user.links.create!(params[:link])
      flash[:messages] = "Your link has been saved"
      redirect_to root_path
    else
      flash.now[:error] = "Please enter a valid link"
      render :new
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      flash[:messages] = "Your link has been saved"
      redirect_to root_path
    else
      flash.now[:error] = "You can only edit a link for 15 minutes after posting"
      render :edit
    end
  end

  private
    def correct_user
      redirect_to(root_path) unless Link.find(params[:id]).user == current_user
    end
end
