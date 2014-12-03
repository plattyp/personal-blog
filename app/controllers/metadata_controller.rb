class MetadataController < ApplicationController

	def index
		@metadata = Metadata.baseinfo.first
	end

	def sitemgmt
		@metadata = Metadata.new
		@baseinfo = Metadata.baseinfo.first
	end
end
