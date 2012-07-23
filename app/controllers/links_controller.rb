class LinksController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @links = Link.all
    @link = Link.new
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    if @link.save
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
      flash.now[:error] = "Please enter a valid information"
      render :edit
    end
  end
end
