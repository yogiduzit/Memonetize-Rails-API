class Api::V1::VotesController < Api::ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authorize_user!, except: [:index]

  def index
    meme = Meme.find(params[:id])
    render(json: {votes: meme.votes})
  end

  def create
    vote = Vote.new vote_params
    vote.user = current_user
    vote.meme = @meme
    if vote.save
      render(json: {sucess: 'Successfully voted'}, status: 200)
    else
      render(json: {errors: vote.errors.full_messages}, status: 422)
    end
  end

  def update
    vote = Vote.find(params[:id])
    update_params = {'vote_type' => vote_params['vote_type']}
    if vote.update(update_params)
      render(json: {sucess: 'Updated', vote_type: update_params['vote_type']}, status: 200)
    else
      render(json: {errors: vote.errors.full_messages}, status: 422)
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:vote_type)
  end

  def authorize_user!
    @meme = Meme.find(params[:meme_id])
    render(json: {error: 'Cannot vote on your own post'}, status: 403) unless can?(:vote, @meme)
  end
end
