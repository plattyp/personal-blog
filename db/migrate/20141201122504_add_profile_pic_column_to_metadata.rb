class AddProfilePicColumnToMetadata < ActiveRecord::Migration
  def change
    add_column :metadata, :profilepic_url, :string
  end
end
