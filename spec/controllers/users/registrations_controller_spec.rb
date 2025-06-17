require 'rails_helper'

RSpec.describe "User Registrations", type: :request do
  describe "POST /users" do
    context "with valid params" do
      let(:valid_attributes) do
        {
          user: {
            email: "user@example.com",
            password: "password123",
            password_confirmation: "password123"
          }
        }
      end

      it "creates a new user and redirects to login with flash notice" do
        post user_registration_path, params: valid_attributes

        expect(response).to redirect_to(new_user_session_path)

        follow_redirect!

        expect(response.body).to include("Cadastro realizado com sucesso! Por favor, faça login.")
        expect(User.exists?(email: "user@example.com")).to be true
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) do
        {
          user: {
            email: "invalid_email",
            password: "123",
            password_confirmation: "456"
          }
        }
      end

      it "does not create user and re-renders the registration page with errors" do
        post user_registration_path, params: invalid_attributes

        expect(response.body).to include("error")

        expect(User.exists?(email: "invalid_email")).to be false
      end
    end
  end
end
