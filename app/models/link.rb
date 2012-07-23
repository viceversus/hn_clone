class Link < ActiveRecord::Base
  attr_accessible :url
  validates :url, :presence => true,
                  :uniqueness => true

  before_save :clean

  def clean
    self.url = "http://" + self.url.gsub(/http:\/\/|https:\/\/|www./, "")
  end
end
