class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many        :comments,  :dependent => :destroy
  has_many        :links,     :dependent => :destroy
  has_many        :votes,     :dependent => :destroy

  def karma
    aggregate_link_score + aggregate_comment_score
  end

  private
    def aggregate_link_score
      score = 0
      self.links.each do |link|
        link.votes.each { |vote| score += vote.value }
      end
      score
    end

    def aggregate_comment_score
      score = 0
      self.comments.each do |comment|
        comment.votes.each { |vote| score += vote.value }
      end
      score
    end
end
