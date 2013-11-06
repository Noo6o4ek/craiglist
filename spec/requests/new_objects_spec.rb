require 'spec_helper'

describe "Not logged in user can't create" do
  let(:user) { build :user }
  let (:advert) { create :advert }

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
  let(:admin) { create :admin }
  let(:user) { build :user }
  let (:advert) { build :advert }

  before(:each) do 
    visit "/users/sign_in"
    fill_in "Login", with: admin.login
    fill_in "Password", with: "administrator"
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

  it "user" do
    visit new_user_path
    current_path.should eq "/users/new"
    fill_in "Login", with: user.login
    fill_in "Full name", with: user.full_name
    fill_in "Email", with: user.email
    select user.country, from: "Country"
    fill_in "Address", with: user.address
    fill_in "City", with: user.city
    fill_in "State", with: user.state
    fill_in "Zip", with: user.zip
    choose('user')
    click_button "Create User"
    # current_path.should eq user_path(user)
    # expect(page).to have_content "User was successfully created"

  end

#   it "comment" do
#     visit advert_path(advert)
#     current_path.should eq "/adverts/#{advert.id}"
#     # page.should_not has_button?("Create comment")
#     # page.should has_field?("comment_body")
#   end
end
