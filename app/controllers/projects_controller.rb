class ProjectsController < ApplicationController
	before_filter :validate_project, only: [:show]

	def index
		@projects = Project.grid
	end

	def show
		@project = Project.find(params[:id])
		@posts   = @project.posts.recent_posts
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
		if @project.save
			redirect_to new_project_path, :notice => "The project was created successfully"
		else
			redirect_to new_project_path, :alert => "The project was unable to be created"
		end
	end

	def edit
		@project = Project.find(params[:id])
		#Main picture so that we can use it for the default value of a given radio button
		@mainpicture = @project.images.mainpictureid
	end

	def update
		@project = Project.find(params[:id])
		#Call method to update the image selected's mainpicindicator to true and the other images to false
		Image.set_main_picture(@project.id,params[:project][:images])
		if @project.update(project_params)
			redirect_to edit_project_path(@project), :notice => "The project was updated successfully"
		else
			redirect_to edit_project_path(@project), :alert => "The project was unable to be updated"
		end
	end

	def destroy
		@project = Project.find(params[:id])
		if @project.destroy
			redirect_to manageprojects_path(@project), :notice => "The project was deleted successfully"
		else
			redirect_to manageprojects_path(@project), :alert => "The project was unable to be deleted"
		end
	end

	def manage
		@projects = Project.recent_projects
	end

	private

	def project_params
		params.require(:project).permit(:name,:visible,:github_url,:url,:description,:appstore_url,:snippet,images_attributes: [:id,:image])
	end

	def validate_project
		project = Project.find(params[:id])
		unless project.visible
		  redirect_to root_path, :alert => "That project does not exist"
		end
	end
end
