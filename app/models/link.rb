class Link < ActiveRecord::Base
  attr_accessible :url

  validates     :url,       :presence   => true,
                            :uniqueness => true
  validates     :user_id,   :presence   => true


  belongs_to    :user
  has_many      :votes,     :dependent  => :destroy

  # default_scope :order      => 'links.created_at DESC'

  before_update :within_15_mins?
  before_save   :clean

  def self.sort_by_votes
    Link.all.sort {|a, b| b.votes.count <=> a.votes.count}
  end


  private

  def clean
    self.url = "http://" + self.url.gsub(/http:\/\/|https:\/\/|www./, "")
  end

  def within_15_mins?
    (Time.now - self.created_at) < 900
  end
end
