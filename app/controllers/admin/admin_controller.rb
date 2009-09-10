class Admin::AdminController < ApplicationController
  layout 'admin'
  
  before_filter :require_user
  before_filter :require_admin
  
  protected
  
    def require_admin
      unless current_user.admin?
        flash[:error] = 'You are not authorized to view this page.'
        redirect_to login_url
      end
    end
end