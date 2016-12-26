class ImagesController < ApplicationController
  def destroy
    @image = Image.find(params[:id])
    if @image.destroy
      redirect_to :back, notice: 'The image was deleted successfully'
    else
      redirect_to :back, alert: 'The image was not able to be deleted'
    end
  end
end
