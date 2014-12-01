class AddColumnsToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :project_id, :integer
  	add_column :posts, :title, :string
  end
end
