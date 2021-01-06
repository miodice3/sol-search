class UserMailer < ApplicationMailer

    default from: 'notifications@example.com'

    def welcome_email
        @user = params[:user]
        @url  = 'http://localhost:3000/'
        mail(to: @user.email, subject: 'Welcome to sol-search')
    end


end
