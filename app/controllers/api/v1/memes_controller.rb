class Api::V1::MemesController < Api::ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def check_pro(memes)
    if current_user && current_user.is_pro
      memes
    else
      memes.limit(20)
    end
  end

  def index 
    memes = Meme.order(created_at: :desc)

    if (params[:tag_name])
      tag = Tag.find_by_name params[:tag_name]

      render(json: check_pro(tag.memes.order(created_at: :desc)), each_serializer: MemeSerializer)
    else
      render(json: check_pro(memes), each_serializer: MemeSerializer)
    end             


  end

  def show
    meme = Meme.find(params[:id])
    render(json: meme, each_serializer: MemeSerializer)
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

  def destroy
    meme = Meme.find(params[:id])
    meme.destroy

    render(json: {success: "Meme successfully deleted"})
  end

  def update
    meme = Meme.find(params[:id])
    if meme.update(meme_params)
      render(json: {id: meme.id, success: "Meme successfully updated"})
    else
      render(json: {errors: meme.errors.full_messages})
    end
  end

  private
  def meme_params
    params.permit(:title, :body, :meme_img, :tag_names)
  end

end
