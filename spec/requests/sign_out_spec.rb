require 'spec_helper'

describe "User can sign out" do
  let(:user) { create :user }

  it "succesfully signs out" do
    visit "/users/sign_in"
    fill_in "Login", with: user.login
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content "Sign out"
    click_link "Sign out"
    expect(page).to have_content "Signed out successfully."
  end
end
