class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  validates :password, presence: true
  validate :confirm_password

  def confirm_password
    if password != password_confirmation
      errors.add(:password_confirmation, "must be equal to password")
    end
  end

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  has_secure_password
end
