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
    meme.meme_img.attach(params[:meme_img])

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
    params.permit(:title, :body, :meme_img)
  end

end
