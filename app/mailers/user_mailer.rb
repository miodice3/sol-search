class UserMailer < ApplicationMailer

    # default from: 'notifications@example.com'

    def welcome_email
        @user = params[:user]        
        mail to: @user.email, subject: "#{@user.name}, Welcome to sol-search! Please confirm your e-mail"
    end

    def contract_recieved_email
        @location = params[:location]
        @user = params[:user]
        mail to: @user.email, subject: "#{@location.name} has recieved a proposal on sol-search!"
    end

    def contract_accepted_email_owner
        @owner = params[:owner]
        @consumer = params[:consumer]
        @location = params[:location]
        @contract = params[:contract]
        mail to: @owner.email, subject: "sol-search, Accepted Contract Details for #{@location.name}"
    end

    def contract_accepted_email_consumer
        @owner = params[:owner]
        @consumer = params[:consumer]
        @location = params[:location]
        @contract = params[:contract]
        mail to: @consumer.email, subject: "sol-search, Accepted Contract Details for #{@location.name}"
    end

    def contract_declined_email_consumer
        @consumer = params[:consumer]
        @location = params[:location]
        @contract = params[:contract]
        mail to: @consumer.email, subject: "sol-search, Declined Contract Details for #{@location.name}"
    end

end
