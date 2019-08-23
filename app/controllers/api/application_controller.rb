class Api::ApplicationController < ApplicationController

  skip_before_action :verify_authenticity_token

  private

  def authenticate_user!
    unless current_user.present?
      render(json: { message: "User not signed in" }, status: 403)
    end
  end

  helper_method :authenticate_user!
end
