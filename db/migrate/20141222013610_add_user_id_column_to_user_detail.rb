class AddUserIdColumnToUserDetail < ActiveRecord::Migration
  def change
    add_column :userdetails, :user_id, :integer
  end
end
