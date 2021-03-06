class Image < ActiveRecord::Base
  # Define relationships
  belongs_to :imageable, polymorphic: true

  # For Paperclip
  has_attached_file :image,
                    styles: {
                      thumb: ['100x100#', :jpg, quality: 50]
                    },
                    url: ':s3_domain_url',
                    bucket: ENV['S3_BUCKET'],
                    path: ':class/:id.:style.:extension'

  validates_attachment :image,
                       presence: true,
                       size: { in: 0..2.megabytes },
                       content_type: { content_type: /^image\/(jpeg|png|gif|tiff|ico)$/ }

  # Used to retrieve the main picture for a given post or project
  def self.mainpicture
    picture = where(mainpicindicator: true).first

    if !picture.nil?
      picture.image.url
    else
      # Pick a random sample picture from images
      ['Gears.png', 'LightBulb.png', 'Rocket.png'].sample
    end
  end

  # Used to retrieve the id of a main picture
  def self.mainpictureid
    where(mainpicindicator: true).pluck('id').first
  end

  # Used to change out a mainpicture when a new one is selected for project or post
  def self.set_main_picture(imageable_id, image_id)
    # Set all mainpicindicator attributes for given imageable_id to false
    images = where('imageable_id = ?', imageable_id)
    images.each do |i|
      i.update(mainpicindicator: false)
    end

    # Set the mainpicindicator to true for the image that was passed
    image = Image.find(image_id)
    image.update(mainpicindicator: true)
  end

  def self.maximum_ordinal(project_id)
    Image.where(imageable_id: project_id, imageable_type: 'Project').maximum(:ordinal)
  end

  def decrement_ordinal
    if ordinal > 0
      self.ordinal -= 1
      save
    end
  end

  def increment_ordinal
    self.ordinal += 1
    save
  end

  # Checks to see if the image is first of the set
  def first_of_project?
    ordinal === 0
  end

  # Checks to see if the image is the last of the set
  def last_of_project?
    maximum = Image.maximum_ordinal(imageable_id)
    return false if maximum == 0
    maximum == ordinal
  end
end
