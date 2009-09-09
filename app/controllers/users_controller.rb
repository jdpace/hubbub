class UsersController < ApplicationController
  before_filter :require_user, :only   => [:show], :unless => :passing_id?
  
  def index
    @users = User.paginate(:page => params[:page], :per_page => App.per_page[:users])
  end
  
  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:notice]  = 'Your account was successfully created.'
      redirect_to account_url
    else
      render :new
    end
  end
  
  protected
  
    def passing_id?
      params[:id]
    end
end
