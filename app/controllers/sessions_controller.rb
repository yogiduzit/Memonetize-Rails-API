class SessionsController < ApplicationController

  def new
    
  end

  def create
    current_user = User.find_by_email(params[:email])

    if !current_user.nil?
      session[:user_id] = current_user.id
      redirect_to welcome_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_sessions_path
  end
  
end
