class VotesSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :meme_id,
    :user_id
  )
end
