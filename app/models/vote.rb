class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :meme

  validate :validate_type

  def validate_type
    if vote_type != '1' && vote_type != '-1'
      self.errors.add(:vote_type, 'is invalid')
    end
  end
end
