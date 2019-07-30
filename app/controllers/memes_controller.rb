class MemesController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize!, only: [:update, :destroy, :edit]

  def new
    @meme = Meme.new
  end

  def create
    @meme = Meme.new meme_params
    @meme.user = current_user

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

      @memes = Meme.limit(20)
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

  def authorize!
    @meme = Meme.find(params[:id])
    redirect_to new_sessions_path unless can?(:crud, @meme)
  end
end
