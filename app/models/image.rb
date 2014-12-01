class Image < ActiveRecord::Base
	after_save :set_main_pic
	belongs_to :imageable, polymorphic: true

	private

	#Set mainpicindicator flag to true for first uploaded pictures for a given project or post
	def set_main_pic
		if Image.count('imageable_id',:conditions => "mainpicindicator = true") == 0
			self.mainpicindicator = true
			self.save
		end
	end
end
