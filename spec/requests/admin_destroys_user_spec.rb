require 'spec_helper'

describe "Admin destroys" do
  let!(:user) { create :user }
  let!(:admin) { create :admin }

  describe "user" do
    def do_login
      visit "/users/sign_in"
      fill_in "Login", with: admin.login
      fill_in "Password", with: "administrator"
      click_button "Sign in"
    end

    it "should render message" do
      visit users_path
      page.should have_content(user.full_name)
      click_link("#{user.id}")
      current_path.should eq "/users/#{user.id}"
      # click_link("Destroy")
      # destroy_link = "\/users\/#{user.id}\/edit"
      # find(:xpath, "/html/body/div[2]/div/div/div[2]/").click_on('a[3]')
      # find('form_actions')
      # find_link('Delete').click
      # page.should have_content("#{user.address}")
      # click_link("Delete")
      # page.driver.browser.switch_to.alert.accept
      # flash.should eq "asd"
    end
  end
end
