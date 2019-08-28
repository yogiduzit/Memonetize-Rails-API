class Api::V1::VotesController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def create
    vote = Vote.new vote_params
    vote.user = current_user
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
      render(json: {sucess: 'Updated'}, status: 200)
    else
      render(json: {errors: vote.errors.full_messages}, status: 422)
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:meme_id, :vote_type)
  end

  def authorize_user!
    meme = Meme.find(params[:meme_id])
    render(json: {error: 'Cannot vote on your own post'}, status: 403) unless can?(:vote, meme)
  end
end
