class AddDescriptionColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :text
    add_column :users, :education, :text
    add_column :users, :workexperience, :text
    add_column :users, :hobbies, :text
  end
end
