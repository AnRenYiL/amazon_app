class ApplicationController < ActionController::Base
    # protect_from_forgery with: :exception
    # protect_from_forgery :except => :index  
  
    # you can disable csrf protection on controller-by-controller basis:  
    # skip_before_filter :verify_authenticity_token  
end
