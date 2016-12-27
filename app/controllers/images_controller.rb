class ImagesController < ApplicationController
  def mark_as_main
    @image = Image.find(params[:id])

    if Image.set_main_picture(@image.imageable_id, @image.id)
      redirect_to edit_project_path(@image.imageable_id), notice: 'Image was marked as main successfully'
    else
      redirect_to edit_project_path(@image.imageable_id), alert: 'Image could not be marked at this time'
    end
  end

  def move_up
    @image = Image.find(params[:id])
    if @image.increment_ordinal
      redirect_to edit_project_path(@image.imageable_id), notice: 'Image was moved down successfully'
    else
      redirect_to edit_project_path(@image.imageable_id), alert: 'Image failed to move'
    end
  end

  def move_down
    @image = Image.find(params[:id])
    if @image.decrement_ordinal
      redirect_to edit_project_path(@image.imageable_id), notice: 'Image was moved down successfully'
    else
      redirect_to edit_project_path(@image.imageable_id), alert: 'Image failed to move'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    if @image.destroy
      redirect_to :back, notice: 'The image was deleted successfully'
    else
      redirect_to :back, alert: 'The image was not able to be deleted'
    end
  end
end
