class ApplicationController < ActionController::Base
  before_filter :get_metadata
  protect_from_forgery with: :exception

  private

  #Used for the layout to show all base information for the view (including sidebar content)
  def get_metadata
  	@metadata = Metadata.baseinfo.first
  end
  
end
