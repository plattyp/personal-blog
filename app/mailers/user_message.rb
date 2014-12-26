class UserMessage < ActionMailer::Base
  default from: "message@andrewplatkin.com"

  def send_user_message(user_id,message)
  	@message = message
  	@user = User.find(user_id)
  	mail(:to => @user.email, :subject => 'Someone sent you a message!')
  end
end
