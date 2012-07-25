class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to  :user
  belongs_to  :commentable, polymorphic: true
  has_many    :comments,    as: :commentable,     :dependent => :destroy
  has_many    :votes,       as: :voteable,        :dependent => :destroy
end
