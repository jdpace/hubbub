class Admin::PostsController < Admin::AdminController
  before_filter :find_post, :only => [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.ordered.paginate(:page => params[:page], :per_page => App.admin_per_page[:posts])
  end
  
  def show
  end
  
  def new
    @post = Post.new
  end
  
  def edit
  end
  
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    
    if @post.save
      flash[:notice] = 'Congradulations! Your post was successfully created.'
      redirect_to admin_post_path(@post)
    else
      render :new
    end
  end
  
  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = 'Congradulations! Your post was successfully updated.'
      redirect_to admin_post_path(@post)
    else
      render :edit
    end
  end
  
  def destroy
    @post.destroy
    flash[:notice] = 'The post was successfully destroyed.'
    redirect_to admin_posts_path
  end
  
  protected
    
    def find_post
      @post = Post.find_by_url!(params[:id])
    end
  
end
