require 'spec_helper'

describe "user specs" do

  let!(:user) { build :user }
  let!(:admin) { build :admin }
  let!(:moderator) { build :moderator }

  it "builds user" do
    user.full_name.should == "User"
    user.role_name.should == "user"
  end

  it "builds admin" do
    admin.full_name.should == "Administrator"
    admin.role_name.should == "admin"
  end

  it "builds moderator" do
    moderator.full_name.should == "Moderator"
    moderator.role_name.should == "moderator"
  end

  describe "gmaps4rails" do
    it "should render proper coordinates for admin user" do
      admin = User.where(login: "admin").first
      admin.to_gmaps4rails.should == "[{\"lat\":48.0021,\"lng\":37.6962}]"
    end
  end

  describe "abilities" do
    it "user can create articles" do
      # user.
    end
  end
end
