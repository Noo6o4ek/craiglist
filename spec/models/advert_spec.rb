require 'spec_helper'

describe "advert specs" do
  describe "handles validations" do
    subject { build :advert }
    it { should validate_presence_of :user_id }
    it { should have_many(:comments) }
    it { should belong_to(:user) }
  end

  it "builds advert" do
    advert = FactoryGirl.build(:advert)
    advert.respond_to?(:user).should be_true
    advert.user.should_not be_nil
  end

  it "does not alow save advert without user" do
    advert = Advert.create(description: "Blah-blah")
    advert.try(:valid?).should_not be_true
    advert.errors.should have_key(:user_id)
  end
end
