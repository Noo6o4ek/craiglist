require 'spec_helper'

describe "comments specs" do
  describe "handles validations" do
    subject { build :comment }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :advert_id }
    it { should belong_to(:advert) }
    it { should belong_to(:user) }
  end

  it "builds correct comment" do
    comment = FactoryGirl.build(:comment)
    comment.respond_to?(:user).should be_true
    comment.respond_to?(:advert).should be_true
    comment.user.should_not be_nil
    comment.advert.should_not be_nil
  end

  it "does not alow save comment without user" do
    comment = FactoryGirl.build(:comment, user: nil)
    comment.try(:valid?).should_not be_true
    comment.errors.should have_key(:user_id)
  end
end
