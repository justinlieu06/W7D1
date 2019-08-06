class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def login_user!
    session[:session_token] = @user.reset_session_token!
  end

  def check_login_status
    redirect_to cats_url if current_user
  end

  def check_cat_owner
    if @cat.owner != current_user
      flash[:errors] = 'error: you do not own this cat'
      redirect_to cats_url
    end
  end
end
