# Functions for firing email notifications
class UserMailer < ActionMailer::Base
  default from: "JobBoardDemo@theArtOfTechLLC.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def registration_welcome(user)
    @user = user
    mail :to => user.email, :subject => "Welcome!"
  end

  def invitation_welcome(user, temp)
    @user = user
    @temp = temp
    mail :to => user.email, :subject => "Congratulations!"
  end
end