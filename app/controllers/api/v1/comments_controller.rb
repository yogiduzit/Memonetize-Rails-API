class Api::V1::CommentsController < Api::ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :authorize_user!, except: [:create, :show]
  before_action :find_meme

  def show
    comment = Comment.find(params[:id])
    render(json: comment, status: 200, each_serializer: CommentSerializer)
  end

  def create
    comment = Comment.new comment_params
    comment.user = current_user
    comment.meme = @meme
    if comment.save
      render(json: {comment: comment, success: "Successsfully created"}, status: 200)
    else
      render(json: {error: comment.errors.full_messages}, status: 422)
    end
  end

  def update
    if @comment.update comment_params
      render(json: {comment: @comment, success: "Successsfully created"}, status: 200)
    else
      render(json: {error: @comment.errors.full_messages}, status: 422)
    end
  end

  def destroy
    if @comment.delete
      render(json: {success: 'Successfully deleted'}, status: 200)
    else
      render(json: {error: 'Can\'t delete meme'}, status: 400)
    end
  end

  private

  def authorize_user!
    @comment = Comment.find(params[:id])
    render(json: {error: 'Unauthorized'}, status: 403) unless can(:crud, @comment)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_meme
    @meme = Meme.find(params[:meme_id])
  end

end
