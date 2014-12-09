class AddPaperClipColumnsToImage < ActiveRecord::Migration
  def change
    add_column :images, :image_file_name, :string
    add_column :images, :image_content_size, :string
    add_column :images, :image_file_size, :integer
  end
end
