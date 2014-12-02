class AddColumnsToImage < ActiveRecord::Migration
  def change
    add_column :images, :imageable_id, :integer
    add_column :images, :imeageable_type, :string
    remove_column :images, :image_type
  end
end
