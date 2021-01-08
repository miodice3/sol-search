class UserMailer < ApplicationMailer

    # default from: 'notifications@example.com'

    def welcome_email
        # byebug
        @user = params[:user]
        # @user = params[:user]
        # @url  = 'http://localhost:3000/'
        # mail(to: @user.email, subject: 'Welcome to sol-search')
        mail to: @user.email, subject: "#{@user.name}, Welcome to sol-search! Please confirm your account"
        # mail to: @user.email, subject: "#{@user.name} Welcome to sol-search! Please confirm your account"
    end


end
