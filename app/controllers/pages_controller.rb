class PagesController < ApplicationController
  
  def show
    @page = Page.published.find_by_url!(params[:id])
  end
  
end
