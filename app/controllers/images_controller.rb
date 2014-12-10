class ImagesController < ApplicationController
	
	def destroy
		@image = Image.find(params[:id])
		if @image.destroy
			if @image.imageable_type == "Post"
				redirect_to edit_post_path(params[:class_id]), :notice => "The image was deleted successfully"
			elsif @image.imageable_type == "Project"
				redirect_to edit_project_path(params[:class_id]), :notice => "The image was deleted successfully"
			end
		else
			if @image.imageable_type == "Post"
				redirect_to edit_post_path(params[:class_id]), :notice => "The image was unable to be deleted"
			elsif @image.imageable_type == "Project"
				redirect_to edit_project_path(params[:class_id]), :notice => "The image was unable to be deleted"
			end
		end
	end
end
