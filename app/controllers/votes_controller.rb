class VotesController < ApplicationController
  before_filter :load_voteable

  def create
    # link = Link.find(params[:link_id])
    # @vote = current_user.votes.build(:link => link)
    # @vote.up_votes = params[:up_votes]
    # @vote.down_votes = params[:down_votes]
    # if @vote.save
    #   flash[:messages] = "Your vote has been counted!"
    #   redirect_to root_path
    # else
    #   flash[:error] = "Cannot vote on your own or vote twice!"
    #   redirect_to root_path
    # end
    @vote = @voteable.votes.new(:value => params[:value], :user_id => current_user.id)
    if @vote.save
      redirect_to @voteable, notice: 'Vote created.'
    else
      render :new
    end
  end

  def index
    @votes = @voteable.votes
  end

  def new
    @vote = @voteable.votes.new
  end

  private
    def load_voteable
      resource, id = request.path.split('/')[1,2]
      @voteable = resource.singularize.classify.constantize.find(id)
    end
end
