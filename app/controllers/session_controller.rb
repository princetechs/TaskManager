class SessionController < ApplicationController
  include SessionHelper

  def new
    if session[:user_id]
      redirect_to root_path
    end
    @user = User.new
  end
  
  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      sign_in(@user)
      redirect_to teams_path, notice: 'Logged in successfully!'
    else
      handle_failed_login
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to login_path, notice: 'Logged out successfully!'
  end

  private

  def handle_failed_login
    flash.now[:alert] = 'Invalid email or password.'
    render :new
  end
end
