class LinksController < ApplicationController
  before_filter :authenticate_user!,  except: [:index, :show]
  before_filter :authorized_user,     only: [:edit, :update]
  before_filter :within_15_mins?,     only: :update

  def index
    @links = Link.sort_by_votes
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

  def show
    @link = Link.find(params[:id])
    @commentable = @link
    @comments = @commentable.comments
    @comment = Comment.new
  end

  private
    def authorized_user
      redirect_to(root_path) unless Link.find(params[:id]).user == current_user || current_user.admin
    end

    def within_15_mins?
      @link = Link.find(params[:id])
      if !current_user.admin && (Time.now - @link.created_at) > 900
        flash.now[:error] = "You can only edit a link for 15 minutes after posting"
        render :edit
      end
    end
end
