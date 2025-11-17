require 'rails_helper'

RSpec.describe JobOffersController, type: :controller do
  let(:valid_attributes) do
    {
      company_name: "Acme Corp",
      position: "Software Engineer",
      location: "New York",
      work_mode: "onsite",
      work_dimension: "full_time",
      employment_type: "employment_contract",
      experience_level: "junior",
      salary_min: 50000,
      salary_max: 100000,
      description: "Great job opportunity",
      tech_stack: "Ruby, Rails, JS"
    }
  end

  let(:invalid_attributes) do
    valid_attributes.merge(company_name: nil)
  end

  describe "GET #index" do
    it "returns a success response" do
      JobOffer.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      job_offer = JobOffer.create! valid_attributes
      get :show, params: { id: job_offer.to_param }
      expect(response).to be_successful
    end
  end
end
