class CategoriesController < ApplicationController
	
	def index
		@categories = Category.categories_with_counts
		@languages = Language.all_languages
		@category = Category.new
		@language = Language.new
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			redirect_to categories_path, notice: "The category was added successfully"
		else
			redirect_to categories_path, alert: "The category was unable to added"
		end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update(category_params)
			redirect_to edit_category_path(@category), notice: "The category was updated successfully"
		else
			redirect_to edit_category_path(@category), alert: "The category was unable to be updated"
		end
	end

	def destroy
		@category = Category.find(params[:id])
		if @category.destroy
			redirect_to categories_path, notice: "The category was deleted successfully"
		else
			redirect_to categories_path, alert: "The category was unable to be deleted"
		end
	end

	private

	def category_params
		params.require(:category).permit(:name)
	end
end
