class CommentSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :meme_id,
    :user_id,
    :body,
    :created_at,
    :updated_at,
    :authorized,
    :username
  )

  def username
    object.user.full_name
  end

  def authorized
    object.user == current_user
  end
end
