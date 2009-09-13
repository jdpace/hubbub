class Admin::PagesController < Admin::AdminController
  
  def index
    @pages = Page.paginate(:page => params[:page], :per_page => App.admin_per_page[:pages])
  end
  
  def show
    @page = Page.find_by_url!(params[:id])
  end
  
end
