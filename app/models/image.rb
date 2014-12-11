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
  		picture = where(mainpicindicator: true).first

  		if picture != nil
  			picture.image.url
  		else
  			"http://static.guim.co.uk/sys-images/Guardian/Pix/pictures/2012/3/6/1331051759134/Blue-sky-with-clouds-007.jpg"
  		end

  		#where(mainpicindicator: true).first.image.url
  	end

  	def self.allimages
		resultarray = Array.new
		images = Image.all

		images.each do |i|
			resultarray << i.image.url(:original)
		end

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
