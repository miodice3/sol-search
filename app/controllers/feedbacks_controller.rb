class FeedbacksController < ApplicationController

    def new
        @feedback=Feedback.new
    end

    def create
        @feedback=Feedback.create(feedback_params) do |f|
            f.user_id = session[:user_id]
        end
        redirect_to feedbacks_thankyou_path
    end

    def thankyou
    end

    private

    def feedback_params
        params.require(:feedback).permit(:name, :feedback)
    end

end
