class UserdetailsController < ApplicationController
	before_filter :get_current_user
	
	def new
		@userdetail = @user.build_userdetail
	end

	def create
		@userdetail = @user.build_userdetail(userdetail_params)
		if @userdetail.save
			redirect_to edit_user_userdetail_path(@user,@userdetail), :notice => "Details were updated successfully"
		else
			redirect_to new_user_userdetail_path(@user), :alert => "Details were unable to be updated"
		end
	end

	def edit
		@userdetail = @user.userdetail
		@image = @userdetail.build_image
	end

	def update
		@userdetail = Userdetail.find(params[:id])
		if @userdetail.update(userdetail_params)
			redirect_to edit_user_userdetail_path(@user,@userdetail), :notice => "Details were updated successfully"
		else
			redirect_to edit_user_userdetail_path(@user,@userdetail), :alert => "Details were unable to be updated"
		end
	end

	private

	def userdetail_params
		params.require(:userdetail).permit(:description,:education,:workexperience,:hobbies,image_attributes: [:image])
	end

	def get_current_user
		@user = current_user
	end
end
