class ApplicationController < ActionController::Base
#    skip_before_action :require_login, only: [:aboutus]
   before_action :require_login, except: [:aboutus, :login, :signup, :login_post, :googleAuth]

    def aboutus
    end

    private

    def current_user
        session[:user_id]
    end

    def find_user
        @user = User.find_by(id: current_user)
    end

    def require_login
        #byebug
        unless current_user
            flash[:error] = "You must be logged in to access this section"
            redirect_to root_path
        end
    end

    def is_authorized
        if params[:id].to_i != session[:user_id]
            redirect_to root_path
        end
    end

end
