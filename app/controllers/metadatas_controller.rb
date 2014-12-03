class MetadatasController < ApplicationController
	def sitemgmt
		@metadata = Metadata.new
		@baseinfo = Metadata.baseinfo.first
	end
end
