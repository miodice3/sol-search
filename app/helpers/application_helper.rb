module ApplicationHelper

    def current_user
        session[:user_id]
    end

    def find_user
        @user = User.find_by(id: logged_in_id?)
    end
    
end
