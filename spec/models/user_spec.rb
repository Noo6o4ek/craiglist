require 'spec_helper'

describe User do
  it "responds to methods" do
    user = User.first
    # user.full_name.should == "Admin"
    # expect(user.full_name).to eq("Admin")
    expect(user).to respond_to?(:full_name)
  end
end
