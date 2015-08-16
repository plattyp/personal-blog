class Language < ActiveRecord::Base
  has_many :project_languages
  has_many :projects, :through => :project_languages

  scope :all_languages, -> {order('languages.name ASC')}
end
