# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password
  
  protected
  
    def current_site
      # Oneday sites will be looked up by subdomain
      # for now just get the one and only out
      @current_site ||= Site.first
    end
  
end
