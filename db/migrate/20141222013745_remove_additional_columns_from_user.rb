class RemoveAdditionalColumnsFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :description
   	remove_column :users, :education
   	remove_column :users, :workexperience
   	remove_column :users, :hobbies	
  end
end
