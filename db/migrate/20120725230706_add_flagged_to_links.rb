class AddFlaggedToLinks < ActiveRecord::Migration
  def change
    add_column :links, :flagged, :boolean, :default => false
  end
end
