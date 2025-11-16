require 'rails_helper'

RSpec.describe "job_offers/show", type: :view do
  let(:job_offer) { FactoryBot.create(:job_offer) }

  before do
    assign(:job_offer, job_offer)
    render
  end

  it "displays the job offer details" do
    expect(rendered).to include(job_offer.company_name)
    expect(rendered).to include(job_offer.position)
    expect(rendered).to include(job_offer.location)
    expect(rendered).to include(job_offer.tech_stack)
  end
end
