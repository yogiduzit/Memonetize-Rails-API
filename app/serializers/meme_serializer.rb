class MemeSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :body,
    :created_at,
    :meme_img,
    :authorized
  )
  belongs_to(:user, key: :author)

  def meme_img
    S3_BUCKET.object(object.meme_img.key).public_url
  end

  def authorized
    object.user == current_user
  end
end
