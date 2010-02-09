class DashboardsController < ApplicationController
  
  def show
    @home_page = Page.find_by_url('home')
    @posts     = Post.ordered.limit(3).all
  end
  
end
