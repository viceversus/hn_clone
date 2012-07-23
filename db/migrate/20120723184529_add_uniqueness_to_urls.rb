class AddUniquenessToUrls < ActiveRecord::Migration
  def change
    add_index :links, :url, unique: true
  end
end
