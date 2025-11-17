require "rails_helper"

RSpec.describe "Job Application", type: :system do
  include ActiveJob::TestHelper

  let!(:user) { FactoryBot.create(:user, password: "password") }
  let!(:job) { FactoryBot.create(:job_offer) }

  it "allows a user to apply" do
    visit login_path

    fill_in "Enter your email address", with: user.email_address
    fill_in "Enter your password", with: "password"

    click_button "Sign in"
    expect(page).to have_content("Sign out")

    visit job_offer_path(job)

    click_button "Apply for this job"

    expect(page).to have_content("You have already applied to this job.")

    # it works only when deliver_now in model
    # perform_enqueued_jobs do
    #  expect(ActionMailer::Base.deliveries.count).to eq(1)
    # end
  end
end
