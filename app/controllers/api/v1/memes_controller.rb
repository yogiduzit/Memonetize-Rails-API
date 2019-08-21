class Api::V1::MemesController < Api::ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index               
    memes = Meme.order(created_at: :desc)
    render(json: memes, each_serializer: MemeSerializer)
  end

  def show
    meme = Meme.find(params[:id])
    render(json: meme)
  end

  def create
    meme = Meme.new meme_params
    meme.user = current_user

    if meme.save
      render(json: { id: meme.id })
    else
      render(
        json: {errors: meme.errors },
        status: 422
      )
    end
  end

  private
  def meme_params
    params.require(:meme).permit(:meme_img, :title, :body, :created_at)
  end

end


class DirectUploadsController < ActiveStorage::DirectUploadsController
  protect_from_forgery with: :exception  
  skip_before_action :verify_authenticity_token
end