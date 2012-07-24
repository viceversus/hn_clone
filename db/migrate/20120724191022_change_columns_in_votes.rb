class ChangeColumnsInVotes < ActiveRecord::Migration
  def up
    add_column :votes, :down_votes, :integer
    add_column :votes, :up_votes,   :integer
  end

  def down
  end
end
