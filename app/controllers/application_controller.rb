class ApplicationController < ActionController::Base

    def aboutus
    end

    private

    def current_user
        session[:user_id]
    end

    def find_user
        @user = User.find_by(id: current_user)
    end

end
