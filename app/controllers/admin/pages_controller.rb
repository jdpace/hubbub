class Admin::PagesController < Admin::AdminController
  
  def index
    @pages = Page.paginate(:page => params[:page], :per_page => App.admin_per_page[:pages])
  end
  
end
