require "rails_helper"

RSpec.describe "Homepage", type: :system do
  it "shows links for visitors" do
    visit root_path
    expect(page).to have_link("Sign up")
    expect(page).to have_link("Sign in")
  end

  it "shows user info when logged in" do
    user = FactoryBot.create(:user, password: "password123")

    visit login_path
    fill_in "Enter your email address", with: user.email_address
    fill_in "Enter your password", with: "password123"
    click_button "Sign in"

    expect(page).to have_content("Hello, #{user.username}!")
  end
end
