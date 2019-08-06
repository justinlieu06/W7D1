class SessionsController < ApplicationController
  before_action :check_login_status, only:[ :new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      login_user!
      redirect_to cats_url
    else
      @user = User.new(user_name: params[:user][:user_name])
      flash.now[:errors] = ["Not it"]
      render :new
    end
  end

  def destroy
    user = current_user
    user.reset_session_token! if user
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
