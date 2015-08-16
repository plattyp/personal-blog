class LanguagesController < ApplicationController

  def create
    @language = Language.new(language_params)
    if @language.save
      redirect_to categories_path, notice: "The language was added successfully"
    else
      redirect_to categories_path, alert: "The language was unable to added"
    end
  end

  def edit
    @language = Language.find(params[:id])
  end

  def update
    @language = Language.find(params[:id])
    if @language.update(language_params)
      redirect_to edit_language_path(@language), notice: "The language was updated successfully"
    else
      redirect_to edit_language_path(@language), alert: "The language was unable to be updated"
    end
  end

  def destroy
    @language = Language.find(params[:id])
    if @language.destroy
      redirect_to categories_path, notice: "The language was deleted successfully"
    else
      redirect_to categories_path, alert: "The language was unable to be deleted"
    end
  end

  private

  def language_params
    params.require(:language).permit(:name)
  end
end
