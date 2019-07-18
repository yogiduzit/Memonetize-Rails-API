require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "must render the new page" do
      get(:new)

      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "on valid request" do
      def valid_request 
        post(:create, params: {
          user: FactoryBot.attributes_for(:user)
        })
      end

      it "it must create a new user" do
        users_before = User.all.count

        valid_request

        users_after = User.all.count
        expect(users_after).to eq(users_before + 1)
      end

      it "it must redirect to index page" do
        valid_request

        expect(response).to redirect_to(welcome_path)
      end
    end
    context "on invalid request" do
      def invalid_request 
        post(:create, params: {
          user: {
            first_name: "Yogi",
            last_name: "Verma",
            password: "password",
            password_confirmation: "passwor",
            email: "jamesbond007@gmail.com"
          }
        })
      end

      it "must render the new page" do
        invalid_request

        expect(response).to render_template(:new)
      end
      it "must not create a new user" do
        before_create = User.all.count

        invalid_request
        after_create = User.all.count

        expect(before_create).to eq(after_create)
      end
    end
  end

  describe "#destroy" do
  end

end
