class ApplicationController < ActionController::Base
  before_filter :get_metadata
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  #before_action :authenticate_user!

  private

  #Used for the layout to show all base information for the view (including sidebar content)
  def get_metadata
  	@metadata = Metadata.baseinfo.first
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:signupcode]
    devise_parameter_sanitizer.for(:account_update) << [:signupcode, :name, :description, :education, :workexperience, :hobbies, image_attributes: [:id,:image]]
  end
end
