class Image < ActiveRecord::Base
	before_save :set_main_pic
	belongs_to :imageable, polymorphic: true

	private

	#Set mainpicindicator flag to true for first uploaded pictures for a given project or post
	def set_main_pic
		if Image.where('imageable_id = ?',self.imageable_id).count == 0
			self.mainpicindicator = true
		end
	end
end
