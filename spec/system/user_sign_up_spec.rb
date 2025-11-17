require "rails_helper"

RSpec.describe "User signup", type: :system do
  it "allows a user to create an account" do
    visit signup_path

    fill_in "Username", with: "test_user"
    fill_in "Email address", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"

    click_button "Create Account"

    expect(page).to have_content("Sign out")
    expect(User.last.email_address).to eq("test@example.com")
  end

  it "fails with invalid data" do
    visit signup_path

    fill_in "Username", with: ""
    fill_in "Email", with: ""
    fill_in "Password", with: "foo"
    fill_in "Password confirmation", with: "bar"

    click_button "Create Account"
    expect(User.count).to eq(0)
  end
end
