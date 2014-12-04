class AddSnippetColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :snippet, :string
  end
end
