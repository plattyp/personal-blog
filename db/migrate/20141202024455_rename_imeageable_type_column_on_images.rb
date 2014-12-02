class RenameImeageableTypeColumnOnImages < ActiveRecord::Migration
  def change
  	rename_column :images, :imeageable_type, :imageable_type
  end
end
