require 'rails_helper'

RSpec.describe "job_offers/index", type: :view do
  describe "Job Offers Index View" do
    let!(:job_offer1) { FactoryBot.create(:job_offer,
                                          position: "Software Engineer",
                                          company_name: "Tech Corp",
                                          location: "New York",
                                          work_mode: :remote,
                                          work_dimension: :full_time,
                                          experience_level: :mid_level) }
    let!(:job_offer2) { FactoryBot.create(:job_offer,
                                          position: "Data Scientist",
                                          company_name: "Data Inc",
                                          location: "San Francisco",
                                          work_mode: :onsite,
                                          work_dimension: :part_time,
                                          experience_level: :senior) }

    before do
      assign(:job_offers, [ job_offer1, job_offer2 ])
    end

    it "displays a list of job offers" do
      render

      expect(rendered).to match /Software Engineer/
      expect(rendered).to match /Tech Corp/
      expect(rendered).to match /New York/
      expect(rendered).to match /Data Scientist/
      expect(rendered).to match /Data Inc/
      expect(rendered).to match /San Francisco/
    end

    it "shows work mode and experience level correctly" do
      render

      expect(rendered).to match /Remote/
      expect(rendered).to match /Full time/
      expect(rendered).to match /Onsite/
      expect(rendered).to match /Senior/
    end

    it "handles no job offers gracefully" do
      assign(:job_offers, [])
      render

      expect(rendered).to match /No job offers available/
    end
  end
end
