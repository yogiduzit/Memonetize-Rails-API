class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new user_params

    if user.valid?
      user.save
      redirect_to welcome_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
  end
end
