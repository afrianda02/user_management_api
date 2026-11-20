require "swagger_helper"

RSpec.describe "Auth API", type: :request do
  path "/api/v1/auth/register" do
    post "Register a new user" do
      tags "Auth"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            },
            required: %w[name email password password_confirmation]
          }
        }
      }

      response "201", "user created" do
        let(:user) { { user: { name: "Test", email: "t@example.com", password: "password123", password_confirmation: "password123" } } }
        run_test!
      end

      response "422", "invalid params" do
        let(:user) { { user: { name: "", email: "bad", password: "x", password_confirmation: "y" } } }
        run_test!
      end
    end
  end

  path "/api/v1/auth/login" do
    post "Login" do
      tags "Auth"
      consumes "application/json"
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response "200", "logged in" do
        let!(:u) { create(:user, email: "login@example.com") }
        let(:credentials) { { email: "login@example.com", password: "password123" } }
        run_test!
      end

      response "401", "invalid credentials" do
        let(:credentials) { { email: "nope@example.com", password: "wrong" } }
        run_test!
      end
    end
  end
end