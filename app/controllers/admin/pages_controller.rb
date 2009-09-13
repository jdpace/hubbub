class Admin::PagesController < Admin::AdminController
  before_filter :find_page, :only => [:show, :edit, :update, :destroy]
  
  def index
    @pages = Page.paginate(:page => params[:page], :per_page => App.admin_per_page[:pages])
  end
  
  def show
  end
  
  def new
    @page = Page.new
  end
  
  def edit
  end
  
  def create
    @page = Page.new(params[:page])
    
    if @page.save
      flash[:notice] = "Congradulations! Your page was successfully created."
      redirect_to admin_page_path(@page)
    else
      render :new
    end
  end
  
  def update
    if @page.update_attributes(params[:page])
      flash[:notice] = "Congradulations! Your page was successfully updated."
      redirect_to admin_page_path(@page)
    else
      render :edit
    end
  end
  
  def destroy
    @page.destroy
    flash[:notice] = "Don't worry, that page was successfully destroyed."
    redirect_to admin_pages_path
  end
  
  protected
    
    def find_page
      @page = Page.find_by_url!(params[:id])
    end
  
end
