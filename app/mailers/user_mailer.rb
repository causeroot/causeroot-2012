class UserMailer < ActionMailer::Base
  default from: "info@causeroot.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url  = "http://beta.causeroot.org/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email, :subject => "Your password has been reset")
  end
end
