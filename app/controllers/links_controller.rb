class LinksController < ApplicationController
  before_filter :authenticate_user!,  except: [:index, :show]
  before_filter :authorized_user,     only: [:edit, :update, :destroy]
  before_filter :find_link,           except: [:index, :new, :create]

  def index
    if current_user && current_user.admin
      @links = Link.sort_by_votes
    else
      @links = Link.without_flagged.sort_by_votes
    end
  end

  def new
    @link = current_user.links.build(params[:link])
  end

  def create
    if current_user.links.create(params[:link])
      flash[:success] = "Your link has been saved"
      redirect_to root_path
    else
      flash.now[:error] = "Please enter a valid link"
      render :new
    end
  end

  def edit
  end

  def update
    within_15_mins?
    if @link.update_attributes(params[:link])
      flash[:success] = "Your link has been saved"
      redirect_to root_path
    else
      flash.now[:error] = "You can only edit a link for 15 minutes after posting"
      render :edit
    end
  end

  def show
    @commentable = @link
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def destroy
    if find_link.destroy
      flash[:success] = "Your link has been deleted!"
      redirect_to root_path
    else
      flash.now[:error] = "There was an error in deleting your link!"
      render @link
    end
  end

  private

    def find_link
      @link = Link.find(params[:id])
    end

    def authorized_user
      redirect_to(root_path) unless find_link.user == current_user || current_user.admin
    end

    def within_15_mins?
      if !current_user.admin && (Time.now - @link.created_at) > 900
        flash.now[:error] = "You can only edit a link for 15 minutes after posting"
        render :edit
      end
    end
end
