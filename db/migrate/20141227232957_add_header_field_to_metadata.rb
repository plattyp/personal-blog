class AddHeaderFieldToMetadata < ActiveRecord::Migration
  def change
    add_column :metadata, :headertags, :text
  end
end
