class AddColumnsToImageForPaperclip < ActiveRecord::Migration
  def change
    add_column :images, :image_updated_at, :datetime
    add_column :images, :image_content_type, :string
    remove_column :images, :image_content_size
  end
end
