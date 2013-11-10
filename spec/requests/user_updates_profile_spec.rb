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

  it "profile from users page" do
    do_login
    visit users_path
    click_link("Edit")
    fill_in "user_zip", with: "12345"
    click_button "Update"
    expect(page).to have_content("User was successfully updated.")
  end

  it "changes values from users page" do
    do_login
    visit users_path
    click_link("Edit")
    fill_in "user_zip", with: "12345"

    expect{ click_button "Update" }.to change{ User.find(user.id).zip }.from(10001).to(12345)
  end

  describe "fake updates" do
    def fake_udate
      do_login
      visit users_path
      click_link("Edit")
      fill_in "user_zip", with: ""
      click_button "Update"
    end

    it "prevetns to save blanks" do
      fake_udate
      expect(page).to have_content("can't be blank")
    end

    it "doesn't change values" do
      fake_udate
      expect{ click_button "Update" }.to_not change{ User.find(user.id).zip }
    end

    it "redirects to edit action" do
      fake_udate
      page.should have_content("Edit User")
    end
  end
end
