module LinkHelper
  def count_votes(voteable)
    voteable_value = 0
    voteable.votes.each { |vote| voteable_value += vote.value }
    voteable_value
  end
end
