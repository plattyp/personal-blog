class Project < ActiveRecord::Base
  type = 'project'
  has_many :posts
  has_many :images, as: :imageable, dependent: :destroy

  has_many :project_languages
  has_many :languages, through: :project_languages

  accepts_nested_attributes_for :images

  # Should be used for all public facing views
  scope :recent_projects, -> { where('visible = TRUE').order('projects.created_at DESC') }

  # Should be used only for Admin functions (shows hidden posts)
  scope :manage_projects, -> { order('projects.created_at DESC') }

  ## For URL Friendly Names
  def slug
    name.downcase.tr(' ', '-').delete('.')
  end

  def to_param
    "#{id}-#{slug}"
  end

  # Used to generate an array that can be used for form selectors
  def self.selectprojects
    Project.all.pluck('name', 'id')
  end

  # Used to generate an array of "3"s for projects
  def self.grid(language_id = nil)
    array = []
    resultarray = []
    counter = 0
    if !language_id.nil? && Language.find_by_id(language_id)
      projects = Project.recent_projects.joins(:project_languages).where('project_languages.language_id = ?', language_id)
    else
      projects = Project.recent_projects
    end

    projects.each do |p|
      counter += 1
      picture = p.images.mainpicture
      languages = p.languages.map(&:name).join(' ')
      array << [p.to_param, p.name, picture, languages]
      next unless counter == 3
      resultarray << array
      array = []
      counter = 0
    end

    resultarray << array

    resultarray
  end

  # Returns a true or false if the project has images
  def has_images?
    Project.joins(:images).where('projects.id = ?', id).count > 0
  end

  # Returns a true or false if the github_url field is filled in for the project
  def has_github?
    !github_url.blank?
  end

  # Returns a true or false if the appstore_url field is filled in for the project
  def has_appstore?
    !appstore_url.blank?
  end

  # Returns a true or false if the website_url field is is filled in for the project
  def has_website?
    !url.blank?
  end
end
