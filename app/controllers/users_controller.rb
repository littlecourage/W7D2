class UsersController < ApplicationController

  before_action :require_no_user!, only: [:create, :new]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(session_token: session[:session_token])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end