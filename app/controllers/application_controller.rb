class ApplicationController < ActionController::Base
    #logout excluded to allow logged in user to log out if they wish not to confirm email
   before_action :require_login, except: [:aboutus, :login, :signup, :login_post, :googleAuth, :logout]

    def aboutus
    end

    private

    def current_user
        session[:user_id]
    end

    def find_user
        @user = User.find_by(id: current_user)
    end

    def email_validated
        find_user.confirmed
    end

    def require_login
        unless current_user
            flash[:error] = "You must be logged in to access this section"
            redirect_to root_path
        end

        unless email_validated
            flash[:error] = "You must confirm your email to access this section"
            redirect_to root_path
        end
    end

end
