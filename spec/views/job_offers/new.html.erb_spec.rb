require 'rails_helper'

RSpec.describe "job_offers/new", type: :view do
  let(:job_offer) { JobOffer.new }

  before do
    assign(:job_offer, job_offer)
    render
  end

  it "renders a form for new job offer" do
    expect(rendered).to have_selector("form")
    expect(rendered).to include("Company Name")
    expect(rendered).to include("Job Title")
    expect(rendered).to include("Location")
    expect(rendered).to include("Work Mode")
    expect(rendered).to include("Work Dimension")
    expect(rendered).to include("Employment Type")
    expect(rendered).to include("Experience Level")
    expect(rendered).to include("Salary Minimum")
    expect(rendered).to include("Salary Maximum")
    expect(rendered).to include("Description")
    expect(rendered).to include("Tech Stack")
  end
end
