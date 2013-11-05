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
    expect(page).to have_content "Sign in to leave the comment."
    # page.should_not has_button?("Create comment")
  end
end

# describe "Logged in user can create" do
#   let(:admin) { create :admin }
#   let (:advert) { create :advert }

#   before do
#     visit "/users/sign_in"
#     fill_in "Login", with: admin.login
#     fill_in "Password", with: admin.password
#     click_button "Sign in"
#   end

#   it "advert" do
#     visit new_advert_path
#     current_path.should eq "/adverts/new"
#     # page.should has_button?("Create advert")
#     # page.should has_field?("Description")
#   end

#   it "user" do
#     visit new_user_path
#     current_path.should eq "/users/new"
#     # page.should has_button?("Create user")
#   end

#   it "comment" do
#     visit advert_path(advert)
#     current_path.should eq "/adverts/#{advert.id}"
#     # page.should_not has_button?("Create comment")
#     # page.should has_field?("comment_body")
#   end
# end
