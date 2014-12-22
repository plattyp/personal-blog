class Userdetail < ActiveRecord::Base
	belongs_to :user
	has_one :image, as: :imageable, :dependent => :destroy

	accepts_nested_attributes_for :image
end
