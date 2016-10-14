module Signup
  module UsersHelper
    # Logs in the given user.
    def log_in(user)
      session[:user_id] = user.id
    end

    # Remembers a user in a persistent session.
    def remember(user)
      user.remember
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
    end

    # Returns the user corresponding to the remember token cookie.
    def current_user
      if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
      elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
          log_in user
          @current_user = user
        end
      end
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
      !current_user.nil?
    end

    # Forgets a persistent session.
    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end

    # Logs out the current user.
    def log_out
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end

    # check the current user- is it admin ?
     def admin?
       current_user.admin?
     end

    # if current user is not admin, it redirect to root path
    def go_back_if_not_admin
      if not admin?
        redirect_to user_path(current_user), notice: "You do not have any permission to grant this page !"
      end
    end

    ## before_action :authorized?, except: :index
    def authorized?
      if current_user.nil?
        redirect_to login_path, alert: 'Not authorized! Please log in.'
      end
    end
  end
end
