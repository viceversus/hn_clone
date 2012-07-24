class ChangeVotes < ActiveRecord::Migration
  def up
    remove_column :votes, :down_votes
    remove_column :votes, :up_votes

    add_column    :votes, :value, :integer
    add_column    :votes, :voteable_type, :string

    rename_column :votes, :link_id, :voteable_id
  end

  def down
  end
end
