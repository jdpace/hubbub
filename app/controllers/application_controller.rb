# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_site, :current_user_session, :current_user, :logged_in?
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password
  
  protected
  
    def current_site
      # Oneday sites will be looked up by subdomain
      # for now just get the one and only out
      @current_site ||= Site.first
    end
    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session ||=  UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def logged_in?
      current_user
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

  
end
