module SessionHelper
    def sign_in(user)
      session[:user_id] = user.id
      session[:expires_at] = 1.hour.from_now
    end
  
    def sign_out(user)
      reset_session # Clears all session data
    end
  end
  