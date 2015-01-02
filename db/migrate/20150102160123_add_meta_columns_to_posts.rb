class AddMetaColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :metadescription, :text
    add_column :posts, :metakeywords, :text
  end
end
