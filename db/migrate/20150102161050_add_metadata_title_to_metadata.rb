class AddMetadataTitleToMetadata < ActiveRecord::Migration
  def change
    add_column :metadata, :metatitle, :string
  end
end
