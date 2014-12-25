class MetadataController < ApplicationController
  	before_filter :get_selectors, only: [:index,:sitemgmt]

	def index
		@metadata = Metadata.baseinfo.first
	end

	def sitemgmt
		@metadata = Metadata.new
		@baseinfo = Metadata.baseinfo.first
	end

	def update
		@metadata = Metadata.find(params[:id])
		if @metadata.update(metadata_params)
			redirect_to metadata_path, :notice => "The site settings have been updated"
		else
			redirect_to metadata_path, :notice => "The site settings were unable to be updated"
		end
	end

	private

	def metadata_params
		params.require(:metadata).permit(:title,:keywords,:description,:profilepic_url,:bannerpic_url,:favicon_url,:googletags,:aboutmeuser, images_attributes: [:id,:image])
	end

	def get_selectors
		@users = User.selectusers
	end
end
