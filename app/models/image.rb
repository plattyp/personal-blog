class Image < ActiveRecord::Base
	before_save :set_main_pic
	
	#Define relationships
	belongs_to :imageable, polymorphic: true

	#For Paperclip
	has_attached_file :image, 
	:styles => {
		  :thumb    => ['100x100#',  :jpg, :quality => 50],
		  :preview  => ['480x480#',  :jpg, :quality => 50],
		  :large    => ['600>',      :jpg, :quality => 80],
		  :retina   => ['1200>',     :jpg, :quality => 50]
		},
	:url => ":s3_domain_url",
	:bucket => Rails.application.secrets.S3_BUCKET,
	:path => ":class/:id.:style.:extension"

  	validates_attachment :image,
  		:presence => true,
  		:size => { :in => 0..2.megabytes },
  		:content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

  	#Used to retrieve the main picture for a given post or project
  	def self.mainpicture
  		where(mainpicindicator: true).first.image.url(:thumb)
  	end

  	def self.imageportfolio
		array = Array.new
		resultarray = Array.new
		counter = 0
		images = Image.all

		images.each do |i|
			counter += 1
			puts "counter #{counter}"
			array << i
			puts "#{array}"
			if counter == 3
				resultarray << array
				array = Array.new
				counter = 0
			end
		end

		resultarray << array
		
		return resultarray
  	end

	private

	#Set mainpicindicator flag to true for first uploaded pictures for a given project or post
	def set_main_pic
		if Image.where('imageable_id = ?',self.imageable_id).count == 0
			self.mainpicindicator = true
		end
	end
end
