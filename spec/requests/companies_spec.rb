require 'rails_helper'

RSpec.describe "Companies", type: :request do
  describe "GET /check_exists" do
    it "returns http success" do
      get "/companies/check_exists"
      expect(response).to have_http_status(:success)
    end
  end
end
