require 'spec_helper'

describe "UserLogins" do
  let(:user) { create :user }

  it "successfully logins" do
    visit "/users/sign_in"
    fill_in "Login", with: user.login
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content "Signed in successfully."
    expect(page).to have_content "Signed in as #{user.login} Not you? Sign out"
  end

  it "fails to login" do
    visit "/users/sign_in"
    fill_in "Login", with: "Abracadabra"
    fill_in "Password", with: "login_fails"
    click_button "Sign in"
    expect(page).to have_content "Invalid login or password."
  end
end
