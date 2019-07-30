class Meme < ApplicationRecord

  belongs_to :user
  
  validates :img_url, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
