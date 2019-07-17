class ApplicationController < ActionController::Base
  private
  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    unless user_signed_in?
      flash[:danger] = "Please sign in"
      redirect_to new_sessions_path
    end
  end
end
