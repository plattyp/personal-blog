class RenameImageableColumnOnImage < ActiveRecord::Migration
  def change
  	rename_column :images, :imageable, :imageable_id
  end
end
