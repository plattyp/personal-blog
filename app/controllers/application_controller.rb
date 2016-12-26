class ApplicationController < ActionController::Base
  before_filter :get_metadata
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  private

  # Used for the layout to show all base information for the view (including sidebar content)
  def get_metadata
    @metadata = Metadata.baseinfo.first
    case params[:controller]
    when 'posts'
      case params[:action]
      when 'index'
        @metadata.metatitle = @metadata.metatitle + ' | Posts'
      when 'show'
        post = Post.find(params[:id])
        @metadata.metadescription = post.metadescription
        @metadata.keywords = post.metakeywords
        @metadata.metatitle = @metadata.metatitle + ' | ' + post.name
      end
    when 'projects'
      case params[:action]
      when 'index'
        @metadata.metatitle = @metadata.metatitle + ' | Projects'
      when 'show'
        project = Project.find(params[:id])
        @metadata.metadescription = project.description
        @metadata.keywords = project.keywords
        @metadata.metatitle = @metadata.metatitle + ' | ' + project.name
      end
    when 'users'
      case params[:action]
      when 'show'
        @metadata = Metadata.baseinfo.first
        user = User.find(@metadata.aboutmeuser)
        @metadata.metatitle = user.name + ' | About Me'
        # Get the description
        description = user.userdetail.description
        # Parsed out using Nokogiri
        desctext = Nokogiri::HTML(description)
        # Setting description
        @metadata.metadescription = desctext.text
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:signupcode]
    devise_parameter_sanitizer.for(:account_update) << [:signupcode, :name, :description, :education, :workexperience, :hobbies, image_attributes: [:id, :image]]
  end
end
