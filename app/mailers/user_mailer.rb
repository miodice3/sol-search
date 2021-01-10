class UserMailer < ApplicationMailer

    # default from: 'notifications@example.com'

    def welcome_email
        @user = params[:user]        
        mail to: @user.email, subject: "#{@user.name}, Welcome to sol-search! Please confirm your e-mail"
    end

    def contract_recieved_email
        @user = params[:user]
        @location = params[:location]
        mail to: @user.email, subject: "#{@location.name} has recieved a proposal on sol-search!"
    end

end
