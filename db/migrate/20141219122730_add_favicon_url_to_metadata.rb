class AddFaviconUrlToMetadata < ActiveRecord::Migration
  def change
    add_column :metadata, :favicon_url, :string
  end
end
