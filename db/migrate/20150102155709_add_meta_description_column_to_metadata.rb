class AddMetaDescriptionColumnToMetadata < ActiveRecord::Migration
  def change
    add_column :metadata, :metadescription, :text
  end
end
