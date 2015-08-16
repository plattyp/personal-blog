class Metadata < ActiveRecord::Base
	type = "metadata"
	has_many :images, as: :imageable
	accepts_nested_attributes_for :images

	scope :baseinfo, -> {}

end
