class ChangeOrdinalToNotNull < ActiveRecord::Migration
  def change
    change_column :images, :ordinal, :integer, default: 0, null: false
  end
end
