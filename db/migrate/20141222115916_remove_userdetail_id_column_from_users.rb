class RemoveUserdetailIdColumnFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :userdetail_id
  end
end
