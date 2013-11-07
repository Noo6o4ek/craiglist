require 'spec_helper'

describe "Not logged in user can't create" do
  let(:user) { build :user }
  let(:advert) { create :advert }

  it "advert" do
    visit new_advert_path
    current_path.should eq "/"
    expect(page).to have_content "You can't perform this action."
  end

  it "user" do
    visit new_user_path
    current_path.should eq "/"
    expect(page).to have_content "You can't perform this action."
  end

  it "comment" do
    visit advert_path(advert)
    current_path.should eq "/adverts/#{advert.id}"
    expect(page).to have_content "Sign in to post comments"
    page.should_not have_button("Create comment")
  end
end

describe "Logged in user can create" do
  let(:user) { create :user }
  let(:advert) { build :advert }
  let(:admin_advert) { create :admin_advert }

  before(:each) do 
    visit "/users/sign_in"
    fill_in "Login", with: user.login
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

  it "advert" do
    visit new_advert_path
    current_path.should eq "/adverts/new"
    fill_in "advert_description", with: advert.description
    click_button "Create Advert"
    expect(page).to have_content "Advert was successfully created."
    expect(page).to have_content advert.description
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
  end

  it "comment" do
    visit advert_path(admin_advert)
    current_path.should eq "/adverts/#{admin_advert.id}"
    fill_in "comment_body", with: "Test comment"
    click_button "Create Comment"
    expect(page).to have_content "Test comment"
    expect(page).to have_content user.full_name
  end
end
