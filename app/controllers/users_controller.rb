class UsersController < ApplicationController
  def show
    @metadata = Metadata.baseinfo.first
    @user = User.find(@metadata.aboutmeuser)
  end

  def message
    @id = params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def sendmessage
    # Checks to see the message is not blank. if it isn't, the message is sent
    unless params[:message].blank?
      UserMessage.send_user_message(params[:user_id], params[:message]).deliver
      redirect_to :back, notice: 'Your message was sent successfully!'
    end
  end
end
