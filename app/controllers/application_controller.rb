class ApplicationController < ActionController::Base
    # protect_from_forgery with: :exception
    # protect_from_forgery :except => :index  
  
    # you can disable csrf protection on controller-by-controller basis:  
    # skip_before_filter :verify_authenticity_token 
    def current_user
      @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method :current_user

    def user_signed_in?
      current_user.present?
    end
    helper_method :user_signed_in?

    def authenticate_user!
      # redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
      unless user_signed_in?
        flash[:danger] = "You betta sign yo self in foo!"
        redirect_to new_session_path
    end
    end
    

    

end
