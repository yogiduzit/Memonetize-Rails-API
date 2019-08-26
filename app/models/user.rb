class User < ApplicationRecord

  has_many :memes, dependent: :destroy
  has_many :user_taggings, dependent: :destroy
  has_many :tags, through: :user_taggings

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def tag_names
    self.tags.map{|tag|
      tag.name
    }.join(', ')
  end

  def tag_names=(rhs)
    self.tags = rhs.strip.split(/\s*,\s*/).map do |tag_name|
      Tag.find_or_initialize_by(name: tag_name)
    end
  end

  has_secure_password
end
