class UsersController < ApplicationController
  before_filter :require_user, :only => [:edit, :update]
  
  def index
    if current_user && current_user.admin?
      @users = User.all
    else
      redirect_to root_path
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def account
    if @user = current_user
      @songs = @user.voted_for_songs.paginate(:per_page => 10, :page => params[:page])
      @notes = @user.created_stories
      @followings = @user.following_users
      @followers = @user.user_followers
      render :action => :show
    else
      redirect_back_or_default root_url
    end
  end
  
  def show
    @user = User.find(params[:id])
    @songs = @user.voted_for_songs.paginate(:per_page => 10, :page => params[:page])
    @notes = @user.created_stories
    @followings = @user.following_users
    @followers = @user.user_followers
  end

  def edit
    @user = current_user
    @authorizations = current_user.authorizations if current_user
  end
  
  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end