require "swagger_helper"

RSpec.describe "Users API", type: :request do
  path "/api/v1/users" do
    get "List users" do
      tags "Users"
      security [ { Bearer: [] } ]
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false

      response "200", "users listed" do
        let!(:user) { create(:user) }
        before { @headers = auth_headers_for(user) }
        let(:Authorization) { @headers["Authorization"] }
        run_test!
      end

      response "401", "unauthorized" do
        run_test!
      end
    end
  end
end