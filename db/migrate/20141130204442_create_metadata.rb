class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.string :title
      t.text :keywords
      t.text :description

      t.timestamps
    end
  end
end
