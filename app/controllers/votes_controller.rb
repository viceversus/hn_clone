class VotesController < ApplicationController
  before_filter :load_voteable

  def create
    @vote = @voteable.votes.new(:value => params[:value], :user_id => current_user.id)
    if @vote.save
      flash.now[:success] = "Your vote has been counted!"
      respond_to do |format|
        format.html { redirect_to @voteable; flash[:success] = "Your vote has been counted!" }
        format.js
      end
    else
      flash.now[:error] = "Cannot vote on your own or vote twice!"
      respond_to do |format|
        format.html { redirect_to @voteable }
        format.js
      end
    end
  end

  private
    def load_voteable
      resource, id = request.path.split('/')[1,2]
      @voteable = resource.singularize.classify.constantize.find(id)
    end
end
