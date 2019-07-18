class SessionsController < ApplicationController

  def new
    
  end

  def create
    current_user = User.find_by_email(params[:email])

    if authenticate_user!
      session[:user_id] = current_user
    else

      flash[:alert] = "The email or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    # redirect_to sign_in_path
  end
  
end
