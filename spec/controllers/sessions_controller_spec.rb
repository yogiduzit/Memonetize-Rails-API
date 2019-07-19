require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "#new" do
    it "must render the new template" do
      get(:new)

      expect(response).to render_template(:new)
    end
  end
  describe "#create" do

    context "valid request" do
      def valid_request(user)
        post(:create, params: {
          email: user.email, 
          password: user.password
        })
      end
      it "must set the session_user_id" do
        user = FactoryBot.create(:user)

        valid_request(user)

        expect(session[:user_id]).to_not be(nil)
      end
      it "must redirect to memes index page" do
      end
    end

    context "invalid request" do
      def invalid_request
        post(:create, params: {
          email: "itsyogi@gmail.com",
          password: "cksl cdm ds"
        })
      end

      it "must not set the user_id" do
        user_id_before_create = session[:user_id]

        invalid_request

        expect(session[:user_id]).to be(user_id_before_create)
      end
    end
  end
end
