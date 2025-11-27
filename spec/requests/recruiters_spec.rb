require 'rails_helper'

RSpec.describe "Recruiters", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/recruiters/show"
      expect(response).to have_http_status(:success)
    end
  end

end
