class PostsController < ApplicationController
  
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => App.per_page[:posts])
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
end
