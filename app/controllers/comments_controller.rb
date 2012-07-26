class CommentsController < ApplicationController
  before_filter :load_commentable

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user_id = current_user.id if current_user
    if @comment.save
      flash[:success] = "Comment created."
      redirect_to @commentable
    else
      flash[:alert] = "Please sign in."
      redirect_to new_user_session_path
    end
  end

  def show
    @parent_comment = Comment.find(params[:id])
    @commentable = @parent_comment
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to root_path
    else
      render 'show'
    end
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
