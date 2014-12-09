class RemoveImageUrlColumnFromImages < ActiveRecord::Migration
  def change
  	remove_column :images, :image_url
  end
end
