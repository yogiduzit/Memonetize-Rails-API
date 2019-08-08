class MemeSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :body,
    :created_at,
    :meme_img
  )
  belongs_to(:user, key: :author)

  def meme_img
    S3_BUCKET.object(object.meme_img.key).url
  end
end
