class Vote < ActiveRecord::Base
  attr_accessible           :link_id, :user_id, :link
  validates_uniqueness_of   :user_id, :scope => :link_id
  belongs_to                :link
  before_create             :check_if_author

  private

  def check_if_author
    self.link.user_id != self.user_id
  end
end
