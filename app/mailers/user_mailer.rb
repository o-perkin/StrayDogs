class UserMailer < ApplicationMailer
  helper :mailer

  default from: ENV['gmail_username']
 
  def email_after_subscribing(user, subscriptions)
    @user = user
    @subscriptions = subscriptions
    mail(to: @user.email, subject: 'Ви підписались!')
  end

  def email_if_dog_already_wanted(user, subscriptions)
    @user = user
    @subscriptions = subscriptions
    mail(to: @user.email, subject: 'На сайті вже шукають вашу собаку!')  do |format|
      format.html(content_transfer_encoding: "quoted-printable")
    end
  end

  def email_after_creating_dog(user)
    @user = user
    mail(to: @user.email, subject: 'Ви додали собаку!')
  end

  def email_if_dog_appeared(user, subscriptions)
    subscriptions.each do |subscription|
      @user = subscription.subscribe.user
      @dog = user.dogs.last
      mail(to: @user.email, subject: "На сайті з'явилась потрібна вам собака!")  
    end 
  end 
end