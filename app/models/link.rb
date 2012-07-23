class Link < ActiveRecord::Base
  attr_accessible :url
  validates :url, :presence => true,
                  :uniqueness => true

  before_save :clean

  belongs_to :user
  validates :user_id, :presence => true
  default_scope order: 'links.created_at DESC'
  before_update :within_15_mins?

  private

  def clean
    self.url = "http://" + self.url.gsub(/http:\/\/|https:\/\/|www./, "")
  end

  def within_15_mins?
    (Time.now - self.created_at) < 900
  end
end
