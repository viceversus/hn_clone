module LinkHelper
  def count_votes(voteable)
    voteable_value = 0
    voteable.votes.each { |vote| voteable_value += vote.value }
    voteable_value
  end

  def admin?
     current_user && current_user.admin
  end

  def full_title(link)
    "#{link.title} (#{link.url})"
  end

  def comment_count(link)
    count = link.comments.length
    "#{count} #{'comment'.pluralize(count)}"
  end
end
