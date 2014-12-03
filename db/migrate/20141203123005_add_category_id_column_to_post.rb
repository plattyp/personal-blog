class AddCategoryIdColumnToPost < ActiveRecord::Migration
  def change
    add_column :posts, :category_id, :integer
    remove_column :posts, :category
  end
end
