class UsersController < ApplicationController
  inherit_resources
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
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_url, :notice => "User created"
    else
      render :action => 'new'
    end
  end

  def update
    @user = User.find params[:id]

    password_blank = params[:user][:password].blank?

    if password_blank
      params[:user][:password] = @user.password
      params[:user][:password_confirmation] = @user.password_confirmation
    end

    if @user.update_attributes! params[:user]

      sign_in @user, bypass: true

      redirect_to users_path, notice: "User updated"

    end

  end

  def destroy
    if User.count == 1
      redirect_to users_path
      flash[:error] = "Can't delete last user"
    else
      destroy!
    end
  end

end
