class DashboardsController < ApplicationController
  
  def show
    @home_page = Page.find_by_url('home')
  end
  
end
