class AddColumnsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :description, :string
    add_column :projects, :url, :string
    add_column :projects, :appstore_url, :string
  end
end
