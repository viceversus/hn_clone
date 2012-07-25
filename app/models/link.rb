class Link < ActiveRecord::Base
  attr_accessible :url, :flagged

  validates     :url,       :presence   => true,
                            :uniqueness => true
  validates     :user_id,   :presence   => true


  belongs_to    :user
  has_many      :votes,     as: :voteable,    :dependent => :destroy
  has_many      :comments,  as: :commentable, :dependent => :destroy

  before_save   :clean

  def self.sort_by_votes
    Link.all.sort {|a, b| b.votes.count <=> a.votes.count}
  end

  private

  def clean
    self.url = "http://" + self.url.gsub(/http:\/\/|https:\/\/|www./, "")
  end
end
