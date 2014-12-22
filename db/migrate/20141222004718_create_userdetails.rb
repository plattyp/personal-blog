class CreateUserdetails < ActiveRecord::Migration
  def change
    create_table :userdetails do |t|
      t.text :description
      t.text :education
      t.text :workexperience
      t.text :hobbies
      t.timestamps
    end
  end
end
