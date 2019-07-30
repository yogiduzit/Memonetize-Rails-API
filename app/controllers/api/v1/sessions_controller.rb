class Api::V1::SessionsController < Api::ApplicationController

  def create 
    user ||= User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])

      session[:user_id] = user.id

      render(json: { user_id: user.id }, status: 200)
    else
      render(json: { status: 422}, status: 422)
    end
  end

  def destroy
    session[:user_id] = nil
    render(json: {status: 200}, status: 200)
  end

end
