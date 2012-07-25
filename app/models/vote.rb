class Vote < ActiveRecord::Base
  attr_accessible           :voteable_id, :user_id, :link, :value
  validates_uniqueness_of   :user_id,         :scope => [:voteable_type, :voteable_id]
  belongs_to                :voteable,        polymorphic: true
  before_save               :check_if_author

  private

  def check_if_author
    self.voteable.user_id != self.user_id
  end
end
