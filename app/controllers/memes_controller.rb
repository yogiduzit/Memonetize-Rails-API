class MemesController < ApplicationController

  def new
    @meme = Meme.new
  end

  def create
    @meme = Meme.new meme_params

    if @meme.valid?
      @meme.save
      redirect_to meme_path(@meme)
    else
      render :new
    end
  end

  def show
    @meme = Meme.find(params[:id])
  end

  def index
    @memes = Meme.all
  end

  def destroy
    meme = Meme.find(params[:id])
    meme.destroy
    redirect_to memes_path
  end

  def edit
    @meme = Meme.find(params[:id])
  end

  def update
    meme = Meme.find(params[:id])
    if meme.update(meme_params)
      redirect_to meme_path(meme)
    else
      render :edit
    end
  end

  private
  def meme_params
    params.require(:meme).permit(:img_url, :title, :body)
  end
end
