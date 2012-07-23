class LinksController < ApplicationController
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
end
