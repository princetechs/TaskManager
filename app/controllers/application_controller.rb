class ApplicationController < ActionController::Base
  helper_method :current_user, :check_session

  private

  def current_user
    if session_expired?
      reset_session
      return nil
    end
  
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def check_session
    redirect_to_login unless logged_in? || attempting_login?
  end

  def attempting_login?
    controller_name == 'sessions' && action_name == 'new'
  end
  
  def logged_in?
    !!current_user
  end


  def redirect_to_login
    redirect_to login_path, notice: 'You are not logged in!'
  end
 
end
private
  
def session_expired?
  session[:expires_at].present? && session[:expires_at] < Time.current
end
