class UserMailer < ApplicationMailer
  def confirmation_email(user)
    @url = url_for(controller: 'users', action: 'confirm', token: user.confirmation_token)
    mail(to: user.email, subject: 'Confirmation')
  end
end
