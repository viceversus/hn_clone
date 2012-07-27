class Link < ActiveRecord::Base
  attr_accessible :url, :flagged, :title

  validates     :url,       :presence   => true,
                            :uniqueness => true
  validates     :user_id,   :presence   => true
  validates     :title,     :presence   => true,
                            :uniqueness => true

  belongs_to    :user
  has_many      :votes,     as: :voteable,    :dependent => :destroy
  has_many      :comments,  as: :commentable, :dependent => :destroy

  before_save   :clean

  def self.without_flagged
    self.where("flagged = ?", "f")
  end

  def self.hn_sort
    Link.all.sort {|a, b| b.hn_score <=> a.hn_score }
  end

  def hn_score
   self.vote_sum / ((((Time.now - self.created_at)/60).to_f)**(1.8))
  end

  def vote_sum
    count = 0
    self.votes.each { |vote| count += vote.value }
    count
  end

  private

  def clean
    self.url = "http://" + self.url.gsub(/http:\/\/|https:\/\/|www./, "")
  end
end
