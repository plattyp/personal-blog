class AddAboutMeColumnToMetadata < ActiveRecord::Migration
  def change
    add_column :metadata, :aboutmeuser, :integer
  end
end
