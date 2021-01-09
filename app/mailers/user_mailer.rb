class UserMailer < ApplicationMailer

    # default from: 'notifications@example.com'

    def welcome_email
        @user = params[:user]        
        mail to: @user.email, subject: "#{@user.name}, Welcome to sol-search! Please confirm your account"
    end

end
