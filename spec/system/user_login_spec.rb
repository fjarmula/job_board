require "rails_helper"

RSpec.describe "User login", type: :system do
  let!(:user) { FactoryBot.create(:user, password: "secret123") }

  it "logs in with correct credentials" do
    visit login_path

    fill_in "Enter your email address", with: user.email_address
    fill_in "Enter your password", with: "secret123"

    click_button "Sign in"

    expect(page).to have_content("Sign out")
  end

  it "fails with incorrect credentials" do
    visit login_path

    fill_in "Enter your email address", with: user.email_address
    fill_in "Enter your password", with: "wrong"

    click_button "Sign in"

    expect(page).to have_content("Try another email address or password.")
  end
end
