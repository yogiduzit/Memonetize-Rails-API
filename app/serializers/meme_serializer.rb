class MemeSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :body,
    :created_at,
    :meme_img,
    :authorized,
    :tag_names,
    :upvotes,
    :downvotes,
    :current_user_vote
  )
  belongs_to(:user, key: :author)
  has_many(:comments)

  def upvotes
    object.votes.where(vote_type: '1').count
  end

  def downvotes
    object.votes.where(vote_type: '-1').count
  end

  def current_user_vote
    object.votes.where(user: current_user)[0]
  end

  def meme_img
    S3_BUCKET.object(object.meme_img.key).public_url
  end

  def authorized
    object.user == current_user
  end
end
