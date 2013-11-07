require 'spec_helper'

describe "User creates advert" do
  let(:user) { create :user }
  let(:advert) { build :advert }

  it "succesfully creates" do
    visit root_url
    expect(page).to have_content "sign in"
    click_link "sign in"
    expect(page).to have_content "Password"
    fill_in "Login", with: user.login
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content "Signed in successfully."
    expect(page).to have_content "New Advert"
    click_link "New Advert"
    expect(page).to have_content "Description"
    fill_in "advert_tag_list", with: "auto, test"
    fill_in "advert_description", with: advert.description
    click_button "Create Advert"
    expect(page).to have_content "Advert was successfully created."
  end
end
