class ChangeVotingTypes < ActiveRecord::Migration
  def up
    change_column :votes, :up_votes, :boolean, :default => 0
    change_column :votes, :down_votes, :boolean, :default => 0
  end

  def down
  end
end
