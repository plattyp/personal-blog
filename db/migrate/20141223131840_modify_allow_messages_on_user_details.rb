class ModifyAllowMessagesOnUserDetails < ActiveRecord::Migration
  def change
  	change_column :userdetails, :allowmessages, :boolean, :default => true
  end
end
