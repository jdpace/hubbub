class CommentsController < ApplicationController
  
  def create
    @post         = Post.find_by_url!(params[:post_id])
    @comment      = @post.comments.new(params[:comment])
    @comment.user = current_user if logged_in?
    
    if @comment.save
      redirect_to post_path(@post, :anchor => dom_id(@comment))
    else
      render :template => 'posts/show'
    end
  end
  
end
