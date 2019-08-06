class UsersController < ApplicationController
  before_action :check_login_status, only:[ :new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.save!
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end

 # id              :bigint           not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
