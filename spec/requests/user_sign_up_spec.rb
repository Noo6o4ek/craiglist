require 'spec_helper'

describe "User sign ups" do
  let(:user) { build :user }

  it "successfully sign ups" do
    visit root_url
    expect(page).to have_content "Sign up"
    click_link "Sign up"
    expect(page).to have_content "Password confirmation"
    fill_in "Login", with: user.login
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    fill_in "Full name", with: user.full_name
    fill_in "Email", with: user.email
    page.select user.country, from: "Country"
    fill_in "Address", with: user.address
    fill_in "City", with: user.city
    fill_in "State", with: user.state
    fill_in "Zip", with: user.zip
    click_button "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  it "doesn't alow user to sign u with wrong password & password_confirmation combination" do
    visit root_url
    expect(page).to have_content "Sign up"
    click_link "Sign up"
    expect(page).to have_content "Password confirmation"
    fill_in "Login", with: user.login
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: "wrong_pass_confirmation"
    fill_in "Full name", with: user.full_name
    fill_in "Email", with: user.email
    page.select user.country, from: "Country"
    fill_in "Address", with: user.address
    fill_in "City", with: user.city
    fill_in "State", with: user.state
    fill_in "Zip", with: user.zip
    click_button "Sign up"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it "validates mandatory fields" do
    visit root_url
    expect(page).to have_content "Sign up"
    click_link "Sign up"
    expect(page).to have_content "Password confirmation"
    click_button "Sign up"
    expect(page).to have_content "errors prohibited this user from being saved:"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
    expect(page).to have_content "Full name can't be blank"
    expect(page).to have_content "Login can't be blank"
    expect(page).to have_content "Country can't be blank"
    expect(page).to have_content "Address can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Zip can't be blank"
  end
end
