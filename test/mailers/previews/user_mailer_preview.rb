# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

    # def welcome_email
    #     UserMailer.with(user: User.first).welcome_email
    #     # UserMailer.welcome_email
    # end

    def welcome_email
        # UserMailer.welcome_email(User.first)
        UserMailer.welcome_email
    end

    def welcome_email2
        # UserMailer.welcome_email(User.first)
        UserMailer.with(user: User.last).welcome_email
    end

end
