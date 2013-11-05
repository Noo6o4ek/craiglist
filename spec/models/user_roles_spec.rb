require 'spec_helper'

describe UserRoles do
  context "should have validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
