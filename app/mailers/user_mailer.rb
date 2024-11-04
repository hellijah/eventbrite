class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur Eventbrite')
  end

  def attendance_email(event)
    @event = event
    @admin = event.user
    mail(to: @admin.email, subject: 'Nouvelle participation à votre événement')
  end
end
