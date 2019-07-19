class Meme < ApplicationRecord
  validates :img_url, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
end
