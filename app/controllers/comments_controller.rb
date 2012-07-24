class CommentsController < ApplicationController
  before_filter :load_commentable

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    if @comment.save
      redirect_to @commentable, messages: "Comment Created."
    else
      render :new
    end
  end

  def show
    @parent_comment = Comment.find(params[:id])
    @commentable = @parent_comment
    @comments = @commentable.comments
    @comment = Comment.new
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
