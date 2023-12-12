module SessionHelper
    def sign_in(user)
        session[:user_id] = user.id
    end
    def sign_out(user)
        session[:user_id] = nil
    end
  
end
