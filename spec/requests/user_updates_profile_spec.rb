require 'spec_helper'

describe "User updates" do
  let(:user) { create :user }

  it "profile" do
    visit root_url
    click_link "sign in"
    fill_in "Login", with: user.login
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content "Signed in successfully."
    click_link("#{user.login}")
    current_path.should eq "/users/edit"
    fill_in "user_current_password", with: user.password
    fill_in "user_zip", with: "12345"
    click_button "Update"
    expect(page).to have_content "You updated your account successfully."
    current_path.should eq "/"
  end
end