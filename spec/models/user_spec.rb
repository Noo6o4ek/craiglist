require 'spec_helper'

describe User do

  let!(:user) { build :user }
  let!(:admin) { build :admin }
  let!(:moderator) { build :moderator }

  it "builds user" do
    user.full_name.should == "User"
    user.role_name.should == "user"
    user.gmaps4rails_address.should == "United States, 4 Pennsylvania Plaza, New York, NY, 10001"
    # user.to_gmaps4rails.should == "[{\"lat\":40.7509,\"lng\":-73.9943}]"
  end

  it "builds admin" do
    admin.full_name.should == "Administrator"
    admin.role_name.should == "admin"
  end

  it "builds moderator" do
    moderator.full_name.should == "Moderator"
    moderator.role_name.should == "moderator"
  end
end
