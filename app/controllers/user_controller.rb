class UserController < ApplicationController

  before_action :require_login, only: [:dashboard]
  def require_login
    unless current_user
      redirect_to login_path
    end
  end
  def new
    @user = User.new
  end

  def dashboard
   @user= current_user
  end
  def create
    @user = User.new(user_params)

    if @user.save
      
      redirect_to login_path , notice: 'Account created successfully!'
    else
      redirect_to signup_path, alert: @user.errors.full_messages.join(', ')

    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
