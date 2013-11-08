require 'spec_helper'

describe "User updates" do
  let(:user) { create :user }

    def do_login
      visit root_url
      click_link "sign in"
      fill_in "Login", with: user.login
      fill_in "Password", with: user.password
      click_button "Sign in"
      expect(page).to have_content "Signed in successfully."
      click_link("#{user.login}")
      current_path.should eq "/users/edit"
    end

  it "profile" do
    do_login
    fill_in "user_current_password", with: user.password
    fill_in "user_zip", with: "12345"
    click_button "Update"
    expect(page).to have_content "You updated your account successfully."
    current_path.should eq "/"
  end

  it "fails to update profile" do
    do_login
    fill_in "user_zip", with: "12345"
    click_button "Update"
    expect(page).to have_content "Current password can't be blank"
    current_path.should eq "/users"
  end

  it "deletes himselve" do
    do_login
    click_link "Cancel my account"
    # page.driver.browser.switch_to.alert.accept
  end
end
