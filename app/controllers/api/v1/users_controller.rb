class Api::V1::UsersController < Api::ApplicationController
  before_action :authenticate_user!, except: [:create, :show]


  def create
    user = User.new user_params

    if user.save
      session[:user_id] = user.id
      render(json: {id: user.id}, status: 200)
    else
      render(json: {errors: user.errors.full_messages}, status: 422)
    end
  end

  def show
    user = User.find_by(id: params[:id])

    if user
      render(json: user, status: 200, each_serializer: UserSerializer)
    else
      render(json: {message: "User not found"}, status: 404)
    end

  end

  def current
    render(json: current_user, status: 200, each_serializer: UserSerializer)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email, :tag_names)
  end
end
