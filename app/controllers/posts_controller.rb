class PostsController < ApplicationController
  
  def index
    @posts = Post.ordered.paginate(:page => params[:page], :per_page => App.per_page[:posts])
  end
  
  def show
    @post = Post.find_by_url!(params[:id])
    @comment = @post.comments.new
  end
  
end
