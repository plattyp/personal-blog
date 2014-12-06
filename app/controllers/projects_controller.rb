class ProjectsController < ApplicationController

	def index
		@projects = Project.portfolioprojects
	end

	def show
		@project = Project.find(params[:id])
		@posts   = @project.posts
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
		if @project.save
			redirect_to new_project_path, :notice => "The project was created successfully"
		else
			redirect_to new_project_path, :notice => "The project was unable to be created"
		end
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
		if @project.update(project_params)
			redirect_to edit_project_path(@project), :notice => "The project was updated successfully"
		else
			redirect_to edit_project_path(@project), :notice => "The project was unable to be updated"
		end
	end

	def destroy
	end

	def manage
		@projects = Project.recent_projects
	end

	private

	def project_params
		params.require(:project).permit(:name,:github_url,:url,:description,:appstore_url,:snippet)
	end
end
