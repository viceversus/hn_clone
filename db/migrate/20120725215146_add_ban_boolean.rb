class AddBanBoolean < ActiveRecord::Migration
  def up
    add_column :users, :banned, :boolean, :default => false
    add_column :users, :admin,  :boolean, :default => false
  end

  def down
  end
end
