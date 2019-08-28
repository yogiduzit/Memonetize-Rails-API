class Tag < ApplicationRecord

  has_many :meme_taggings
  has_many :user_taggings
  
  has_many :memes, through: :meme_taggings
  has_many :users, through: :user_taggings



  before_validation :downcase_name

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def downcase_name
    self.name&.downcase
  end
end
