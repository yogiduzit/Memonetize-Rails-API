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

    context "email" do
      it "must be present" do
        user = User.new

        user.valid?

        expect(user.errors.messages).to have_key(:email)
      end

      it "must be unique" do
        correct_user = User.create(first_name: "Yogi", last_name: "Verma", password: "yogiduz", password_confirmation: "yogiduz", 
          email: "itsyogi@gmail.com")
        incorrect_user = User.new(email: "itsyogi@gmail.com")

        incorrect_user.valid?

        expect(incorrect_user.errors.messages).to have_key(:email)
      end
      it "must follow the email format" do
        user_a = User.new(email: "not-an-email")
        user_b = User.new(email: "haha@jaja")
        user_c = User.new(email: "")

        user_a.valid?
        user_b.valid?
        user_c.valid?

        expect(user_a.errors.messages).to have_key(:email)
        expect(user_b.errors.messages).to have_key(:email)
        expect(user_c.errors.messages).to have_key(:email)
      end
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
