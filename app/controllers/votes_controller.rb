class VotesController < ApplicationController
  before_filter :load_voteable

  def create
    @vote = @voteable.votes.new(:value => params[:value], :user_id => current_user.id)
    if @vote.save
      flash[:success] = "Your vote has been counted!"
      redirect_to @voteable
    else
      flash[:error] = "Cannot vote on your own or vote twice!"
      redirect_to @voteable
    end
  end

  private
    def load_voteable
      resource, id = request.path.split('/')[1,2]
      @voteable = resource.singularize.classify.constantize.find(id)
    end
end
