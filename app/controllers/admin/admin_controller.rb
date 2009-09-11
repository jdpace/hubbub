class Admin::AdminController < ApplicationController
  layout 'admin'
  
  before_filter :require_admin
  
  protected
  
    def require_admin
      unless logged_in? && current_user.admin?
        flash[:error] = 'You are not authorized to view this page.'
        redirect_to admin_login_url
      end
    end
end