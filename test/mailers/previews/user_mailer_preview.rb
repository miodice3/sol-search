# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

    def welcome_email
        # UserMailer.welcome_email(User.first)
        UserMailer.with(user: User.last).welcome_email
    end

    def contract_recieved_email
        UserMailer.with(user: User.last, location: Location.last).contract_recieved_email
    end

    def contract_accepted_email_owner
        UserMailer.with(owner: User.last, consumer: User.first, location: Location.last, contract: Contract.last).contract_accepted_email_owner
    end

    def contract_accepted_email_consumer
        UserMailer.with(owner: User.last, consumer: User.first, location: Location.last, contract: Contract.last).contract_accepted_email_consumer
    end

end
