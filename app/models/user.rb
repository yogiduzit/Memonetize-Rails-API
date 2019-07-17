class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validate :confirm_password

  def confirm_password
    if password != password_confirmation
      errors.add(:password_confirmation, "must be equal to password")
    end
  end

  has_secure_password
end
