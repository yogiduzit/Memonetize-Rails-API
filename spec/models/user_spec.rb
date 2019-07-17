require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validates" do
    it "requires a first name" do
      user = User.new

      user.valid?

      expect(user.errors.messages).to have_key(:first_name)

    end

    it "requires a last name" do
      user = User.new

      user.valid?

      expect(user.errors.messages).to have_key(:last_name)
    end

    it "requires an email" do
      user = User.new

      user.valid?

      expect(user.errors.messages).to have_key(:email)
    end

    it "requires a password" do
      user = User.new

      user.valid?

      expect(user.errors.messages).to have_key(:password)
    end

    it "must confirm the password" do
      user = User.new(password: "yogiduzit", password_confirmation: "yogiduz")

      user.valid?

      expect(user.errors.messages).to have_key(:password_confirmation)
    end
  end
end
