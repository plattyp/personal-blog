class AddUserDetailIdColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :userdetail_id, :integer
  end
end
