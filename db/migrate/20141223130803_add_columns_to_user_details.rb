class AddColumnsToUserDetails < ActiveRecord::Migration
  def change
  	add_column :userdetails, :github_url, :string
  	add_column :userdetails, :linkedin_url, :string
  	add_column :userdetails, :allowmessages, :boolean
  end
end
