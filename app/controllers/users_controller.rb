class UsersController < ApplicationController
  layout "admin"

  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user.editing_user = false 
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_url, :notice => "User created."
    else
      render :action => 'new'
    end
  end

end
