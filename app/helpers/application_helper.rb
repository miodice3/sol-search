module ApplicationHelper
    def logged_in?
        session[:user_id]
    end

    def logged_in_id?
        session[:user_id]
    end
    
end
