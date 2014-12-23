class Userdetail < ActiveRecord::Base
	type = "userdetail"
	belongs_to :user
	has_many :images, as: :imageable, :dependent => :destroy

	accepts_nested_attributes_for :images

	#Returns back a profile picture id (First image)
	def profile_pic
		profile_pic = Userdetail.joins(:images).where('userdetails.id = ?', self.id).pluck('images.id').first
	end

	#Returns a true or false if the userdetail has a a profile pic
	def has_profilepic?
		profile_pic != nil
	end

	#Used to delete an old profile picture for a user with the new one just uploaded
	def replace_profile_pic
		images = Userdetail.joins(:images).where('userdetails.id = ?', self.id).select('images.id,images.created_at').order('images.created_at DESC').pluck('images.id,images.created_at')

		#Checks if there are currently more than 2 profile pictures
		if images.count > 1
			#Remove the first value in array, which should be the current profile pic
			imagesfordelete = images.drop(1)

			#Destroys all remaining pictures in the array
			imagesfordelete.each do |i|
				Image.find(i[0]).destroy
			end
		end
	end
end
