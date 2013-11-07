require 'spec_helper'

describe AdvertsController do
  render_views

  let(:user) { create :user }
  let(:advert) { create :advert }
  let(:admin_advert) { create :admin_advert }

  before(:each) do
    sign_in user
  end

  describe "#index" do
    it "renders advert" do
      get :index
      response.should be_success
      expect(response).to render_template("index")
    end
  end

  describe "#show" do
    it 'is success' do
      get :show, id: advert.to_param
      response.should be_success
    end
  end

  describe '#edit' do
    let(:vasya) { create(:user) }
    let!(:advert_by_vasya) { create(:advert, user_id: vasya.id, description: "Before update") }

    def do_update
      put :update, id: advert_by_vasya.to_param, advert: { description:  "updating...", user_id: vasya.to_param }
    end

    def fail_update
      put :update, id: advert_by_vasya.to_param, advert: { description:  "updating...", user_id: user.to_param }
    end

    it 'renders message' do
      sign_in vasya
      do_update
      flash[:notice].should eq "Advert was successfully updated."
    end

    it "renders error" do 
      fail_update
      flash[:error].should eq "You can't perform this action."
    end

    it "redirects to" do
      sign_in vasya
      fail_update
      response.status.should eq 302
    end
  end

  describe '#new' do
    it 'is success' do
      get :new
      response.should be_success
    end
  end

  describe '#create' do
    def do_create
      post :create, advert: { description: "testing", user_id: user.id }
    end

    def fail_create
      post :create, advert: { description: "fail" }
    end

    it 'is success' do
      sign_in user
      expect { do_create }.to change { Advert.count }.by(1)
    end

    it 'renders message' do
      sign_in user
      do_create
      flash[:notice].should eq "Advert was successfully created."
    end

    it "fails to create" do
      expect { fail_create }.to change { Advert.count }.by(0)
    end

    it "redirects to new path" do
      post :create, advert: { description: "fail" }
      response.should render_template(:new)
    end
  end

  describe '#destroy' do
    def do_delete
      delete :destroy, id: advert_by_vasya.to_param
    end

    let!(:comment) { create(:comment, advert_id: advert_by_vasya.id) }
    let(:vasya) { create(:user) }
    let!(:advert_by_vasya) { create(:advert, user_id: vasya.id) }

    it 'is success' do
      do_delete
      response.should redirect_to("/")
    end

    it 'destroys advert' do
      sign_in vasya
      expect { do_delete }.to change { Advert.count }.by(-1)
    end

    it 'destroys joined comment' do
      sign_in vasya
      expect { do_delete }.to change { Comment.count }.by(-1)
    end

    it 'renders error' do
      sign_in user
      do_delete
      flash[:error].should eq "You can't perform this action."
      response.should redirect_to("/")
    end
  end
end