class RemoveUserIdcOlumnOnUserdetails < ActiveRecord::Migration
  def change
  	remove_column :userdetails, :user_id
  end
end
