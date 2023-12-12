class ApplicationController < ActionController::Base
  helper_method :current_user, :check_session

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def check_session
    unless logged_in?
      redirect_user
    end
  end

  def logged_in?
    !!current_user
  end

  def redirect_user
    if controller_name == 'sessions' && action_name == 'new'
      # Allow access to the login page if not logged in
    else
      redirect_to_login
    end
  end

  def redirect_to_login
    redirect_to login_path, notice: 'You are not logged in!'
  end
end
