require "rails_helper"

RSpec.describe "User logout", type: :system do
  let!(:user) { FactoryBot.create(:user, password: "password123") }

  it "logs out successfully" do
    # Log in first
    visit login_path

    fill_in "Enter your email address", with: user.email_address
    fill_in "Enter your password", with: "password123"
    click_button "Sign in"

    # Click logout link
    click_link "Sign out" # adjust name as needed

    expect(page).to have_content("Sign in")
  end
end
