require 'spec_helper'

describe "user specs" do
  describe "handles validations" do
    subject { build :user }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :full_name }
    it { should validate_presence_of :login }
    it { should validate_presence_of :birthday }
    it { should validate_presence_of :country }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should have_many(:adverts) }
    it { should have_many(:comments) }
    it { should belong_to(:user_role) }
  end

  let(:user) { create :user }
  let(:himself) { User.find(user.id) }
  let(:admin) { create :admin }
  let(:moderator) { create :moderator }
  let(:advert) { create :advert }
  let(:admin_advert) { create :admin_advert }
  let(:comment) { create :comment }

  describe "FactoryGirl" do
    it "builds valid users" do
      FactoryGirl.build(:user).should be_valid
      FactoryGirl.build(:admin).should be_valid
      FactoryGirl.build(:moderator).should be_valid
    end
  end

  it "creates user" do
    user.full_name.should == "User"
    user.role_name.should == "user"
  end

  it "creates admin" do
    admin.full_name.should == "Administrator"
    admin.role_name.should == "admin"
  end

  it "creates moderator" do
    moderator.full_name.should == "Moderator"
    moderator.role_name.should == "moderator"
  end

  describe "creates" do
    it "adverts" do
      expect{ user.adverts.create(description: "testing...") }.to change{ Advert.count }.by(1)
    end

    it "comments" do
      expect{ user.comments.create(body: "testing...", advert_id: advert.id) }.to change{ Comment.count }.by(1)
    end
  end

  describe "gmaps4rails" do
    it "should render proper coordinates" do
      admin.latitude.should eq 40.7410262
      admin.longitude.should eq -73.9897806
      moderator.latitude.should eq 50.4486167
      moderator.longitude.should eq 30.45698759999999
      user.latitude.should eq 40.7508707
      user.longitude.should eq -73.99426609999999
    end
  end

  describe "abilities" do
    it "doesn't allow user to manage adverts, comments and another users" do
      ability = Ability.new(user)

      ability.should be_able_to(:manage, Advert.new(user: himself))
      ability.should be_able_to(:manage, Comment.new(user: himself))

      ability.should be_able_to(:edit, himself)
      ability.should be_able_to(:update, himself)
      ability.should be_able_to(:destroy, himself)

      ability.should_not be_able_to(:manage, admin_advert)
      ability.should_not be_able_to(:manage, comment)
      ability.should_not be_able_to(:manage, User.new)
    end

    it "allows admin user to manage everything" do
      ability = Ability.new(admin)

      ability.should be_able_to(:manage, advert)

      ability.should be_able_to(:manage, comment)

      ability.should be_able_to(:manage, user)
      ability.should be_able_to(:manage, moderator)
      ability.should be_able_to(:manage, admin)
    end

    it "allows moderator to manage comments and adverts" do
      ability = Ability.new(moderator)

      ability.should be_able_to(:manage, advert)

      ability.should be_able_to(:manage, comment)

      ability.should be_able_to(:edit, moderator)
      ability.should be_able_to(:update, moderator)
      ability.should be_able_to(:destroy, moderator)

      ability.should_not be_able_to(:manage, user)
      ability.should_not be_able_to(:manage, admin)
    end
  end
end
