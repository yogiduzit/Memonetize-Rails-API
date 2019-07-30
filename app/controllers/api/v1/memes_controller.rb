class Api::V1::MemesController < Api::ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index    
    memes = Meme.all
    render(json: memes)
  end

  def show
    meme = Meme.find(params[:id])
    render(json: meme)
  end

  def create
    meme = Meme.new meme_params
    meme.user = current_user
    p "Yogi"

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
    params.require(:meme).permit(:img_url, :title, :body, :created_at)
  end
end
