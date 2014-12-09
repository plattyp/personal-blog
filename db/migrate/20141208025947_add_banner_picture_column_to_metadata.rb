class AddBannerPictureColumnToMetadata < ActiveRecord::Migration
  def change
    add_column :metadata, :bannerpic_url, :string
  end
end
