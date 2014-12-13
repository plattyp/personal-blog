class AddVisibleColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :visible, :boolean, default: false
  end
end
