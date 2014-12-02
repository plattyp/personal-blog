class AddColumnToImages < ActiveRecord::Migration
  def change
    add_column :images, :mainpicindicator, :boolean, default: false
  end
end
