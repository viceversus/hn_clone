class VotesController < ApplicationController
  def create
    link = Link.find(params[:link_id])
    @vote = current_user.votes.build(:link => link)
    if @vote.save
      flash[:messages] = "Upvoted!"
      redirect_to root_path
    else
      flash[:error] = "Cannot vote on your own or vote twice!"
      redirect_to root_path
    end
    # current_user.votes.create!(:link => link)
    # redirect_to root_path
  end
end
