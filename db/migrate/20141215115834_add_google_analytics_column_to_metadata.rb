class AddGoogleAnalyticsColumnToMetadata < ActiveRecord::Migration
  def change
    add_column :metadata, :googletags, :text
  end
end
