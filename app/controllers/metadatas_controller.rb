class MetadatasController < ApplicationController
	def index
		@metadata = Metadata.baseinfo
	end
end
