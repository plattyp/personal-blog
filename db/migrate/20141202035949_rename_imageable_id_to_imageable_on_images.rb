class RenameImageableIdToImageableOnImages < ActiveRecord::Migration
  def change
  	rename_column :images, :imageable_id, :imageable
  end
end
